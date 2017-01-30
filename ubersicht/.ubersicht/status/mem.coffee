command: "ESC=`printf \"\e\"`; ps -A -o %mem | awk '{s+=$1} END {printf(\"%02.0f\",s/8);}'"

refreshFrequency: 30000 # ms

render: (output) ->
  "mem <span>#{output}</span>"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px "Fira Code Retina"
  right: 295px
  top: 2px
  color: #666
  span
    color: #D5C4A1
"""
