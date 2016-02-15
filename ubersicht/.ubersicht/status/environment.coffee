command: """
WEATHER=$(/Users/brandon/bin/wu --conditions | grep Temperature | cut -d \"(\" -f2 | cut -d \")\" -f1 | sed \"s/\ C/°C/\")
DATE=$(date +\"%a %b %e\")
TIME=$(date +\"%I:%M\")
printf '{"weather": "%s", "date": "%s", "time": "%s"}' "$WEATHER" "$DATE" "$TIME"
"""

refreshFrequency: 5 * 60 * 1000 # ms

render: (output) ->
  output = JSON.parse(output)
  "<div style=\"margin: 0 auto;\"><span>#{output.weather}</span> | <span>#{output.date}</span> | <span>#{output.time}</span></div>"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px "Fira Code Retina"
  width: 100%;
  text-align: center;
  top: 2px
  color: #666
  span
    color: #D5C4A1
"""

