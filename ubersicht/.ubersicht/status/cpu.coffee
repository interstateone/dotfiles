command: "ESC=`printf \"\e\"`; ps -A -o %cpu | awk '{s+=$1} END {printf(\"%02.0f\",s/8);}'"

refreshFrequency: 2000 # ms

render: (output) ->
  "cpu <span>#{output}</span>"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px "Fira Code Retina"
  right: 230px
  top: 2px
  color: #666
  span
    color: #D5C4A1
"""
