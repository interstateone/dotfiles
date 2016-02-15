command: """
  AVAILABLE=$(df -H | grep disk1 | awk '{print $4}')
  echo "$AVAILABLE"
"""

refreshFrequency: 5000 # ms

render: (output) ->
  "dsk <span>#{output}</span>"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px "Fira Code Retina"
  right: 250px
  top: 2px
  color: #666
  span
    color: #D5C4A1
"""

