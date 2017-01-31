command: """
disk=$(df -H | grep disk1 | awk '{print $4}')
mem=$(ESC=`printf \"\e\"`; ps -A -o %mem | awk '{s+=$1} END {printf(\"%02.0f\",s/8);}')
cpu=$(ESC=`printf \"\e\"`; ps -A -o %cpu | awk '{s+=$1} END {printf(\"%02.0f\",s/8);}')
date=$(date +\"%a %b %e\")
time=$(date +\"%I:%M\")
icon=$(/Users/brandon/bin/battery-icon)
percentage=$(/Users/brandon/bin/battery-percentage)
printf '{\
    "diskAvailable": "%s",\
    "memory": "%s",\
    "cpu": "%s",\
    "batteryIcon": "%s",\
    "batteryLevel": "%s",\
    "date": "%s",\
    "time": "%s"\
}' "$disk" "$mem" "$cpu" "$icon" "$percentage" "$date" "$time"
"""

refreshFrequency: 1 * 1000 # ms

render: (output) ->
  output = JSON.parse(output)
  """
  <div class=\"datum\">dsk <span class=\"yellow\">#{output.diskAvailable}</span></div>
  <div class=\"datum\">mem <span class=\"yellow\">#{output.memory}</span></div>
  <div class=\"datum\">cpu <span class=\"yellow\">#{output.cpu}</span></div>
  <div class=\"datum\">bat <span class=\"yellow\">#{output.batteryLevel}</span>#{output.batteryIcon}</div>
  <div class=\"datum\"><span>#{output.date}</span> <span>#{output.time}</span></div>
  """

style: """
  -webkit-font-smoothing: antialiased
  font: 12px "Fira Code Retina"
  position: relative
  margin: 2px 20px 0 0
  float: right
  color: #666
  span
    &.yellow
      color: #D5C4A1
  .datum
    display: inline-block
    margin-right: 10px
"""
