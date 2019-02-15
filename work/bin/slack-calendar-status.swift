#! /usr/bin/swift sh

import Foundation
import EventKit
import PromiseKit  // @mxcl ~> 6.5
import PMKEventKit // @PromiseKit ~> 4.0
import SlackKit    // @pvzig == c1a89ee

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }
}

extension WebAPI {
    func updateStatus(_ text: String, emoji: String, expiration: Date) -> Promise<Void> {
        return Promise { seal in
            let profile = User.Profile(profile: ["status_text": text,
                                                 "status_emoji": emoji,
                                                 "status_expiration": Int(expiration.timeIntervalSince1970)])
            usersProfileSet(profile: profile, 
                            success: { _ in seal.fulfill(()) },
                            failure: { error in seal.reject(error) })
        }
    }
}

enum Error: Swift.Error {
    case notAuthorized
}

let store = EKEventStore()
let slack = WebAPI(token: ProcessInfo.processInfo.environment["SLACK_TOKEN"]!)
let calendar = ProcessInfo.processInfo.environment["CALENDAR"]

firstly {
    store.requestAccess(to: .event)
}
.then { (authorization) -> Promise<Void> in
    guard authorization == .authorized else { throw Error.notAuthorized }

    let calendars = store.calendars(for: .event).filter { $0.title == calendar }
    let predicate = store.predicateForEvents(withStart: Date(), end: Date().endOfDay, calendars: calendars)
    let todaysRemainingEvents = store.events(matching: predicate)

    if let pto = todaysRemainingEvents.first(where: { $0.isAllDay && $0.title.contains("PTO") }) {
        let shortDate = DateFormatter.shortDate.string(from: pto.endDate)
        return slack.updateStatus("PTO until \(shortDate)", 
                                  emoji: ":palm_tree:",
                                  expiration: pto.endDate)
    }
    else if let meeting = todaysRemainingEvents.sorted(by: { $0.startDate < $1.startDate }).first(where: { !$0.isAllDay && $0.availability != .free && $0.startDate < Date() && $0.endDate > Date() }) {
        return slack.updateStatus("In a meeting",
                                  emoji: ":spiral_calendar_pad:",
                                  expiration: meeting.endDate)
    }
    else if let travel = todaysRemainingEvents.first(where: { $0.isAllDay && $0.title.hasPrefix("Travel: ") }) {
        let destination = travel.title.replacingOccurrences(of: "Travel: ", with: "")
        let shortDate = DateFormatter.shortDate.string(from: travel.endDate)
        return slack.updateStatus("In \(destination) until \(shortDate)",
                                  emoji: ":airplane:",
                                  expiration: travel.endDate)
    }

    exit(0)
}
.done {
    exit(0)
}
.catch { error in
    print(String(describing: error))
    exit(1)
}

RunLoop.current.run()
