set from = "brandon.evans@robotsandpencils.com"

set sendmail = "/usr/local/bin/msmtp -a robotsandpencils"
set spoolfile = "+brandon.evans-robotsandpencils.com/INBOX"

set mbox      = "+brandon.evans-robotsandpencils.com/archive"
set postponed = "+brandon.evans-robotsandpencils.com/drafts"

macro index,pager A "<save-message>=brandon.evans-robotsandpencils.com/archive<enter>" "Archive conversation"

set signature = "~/.mutt/robotsandpencils.com.signature"
