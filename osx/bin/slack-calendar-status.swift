#! /usr/bin/swift sh

import Foundation
import EventKit
import PromiseKit // @mxcl ~> 6.5
import SKWebAPI // @RobotsAndPencils == users.profile.set

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

extension EKEventStore {
    func requestAccess(to entityType: EKEntityType) -> Promise<Void> {
        return Promise { seal in
            requestAccess(to: entityType) { granted, error in
                if granted { seal.fulfill(()) }
                else { seal.reject(error ?? PMKError.cancelled) }
            }
        }
    }
}

extension WebAPI {
    func updateStatus(_ text: String, emoji: String, expiration: Date) -> Promise<Void> {
        return Promise { seal in
            let profile = User.Profile(profile: ["status_text": text,
                                                 "status_emoji": emoji,
                                                 "status_expiration": expiration.timeIntervalSince1970])
            usersProfileSet(profile: profile, 
                            success: { _ in seal.fulfill(()) },
                            failure: { error in seal.reject(error) })
        }
    }
}

let store = EKEventStore()
let slack = WebAPI(token: ProcessInfo.processInfo.environment["SLACK_TOKEN"]!)
let calendar = ProcessInfo.processInfo.environment["CALENDAR"]

firstly {
    store.requestAccess(to: .event)
}
.then { () -> Promise<Void> in
    let calendars = store.calendars(for: .event).filter { $0.title == calendar }
    let predicate = store.predicateForEvents(withStart: Date(), end: Date().endOfDay, calendars: calendars)
    let todaysRemainingEvents = store.events(matching: predicate)

    for event in todaysRemainingEvents {
        if event.isAllDay && event.title.contains("PTO") {
            let shortDate = DateFormatter.shortDate.string(from: event.endDate)
            return slack.updateStatus("PTO until \(shortDate)", emoji: ":palm_tree:", expiration: event.endDate)
        }
        else if !event.isAllDay && event.availability != .free {
            return slack.updateStatus("In a meeting", emoji: ":spiral_calendar_pad:", expiration: event.endDate)
        }
        else if event.isAllDay && event.title.hasPrefix("Travel: ") {
            let destination = event.title.replacingOccurrences(of: "Travel: ", with: "")
            let shortDate = DateFormatter.shortDate.string(from: event.endDate)
            return slack.updateStatus("In \(destination) until \(shortDate)", emoji: ":airplane:", expiration: event.endDate)
        }
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
