command: "/Users/brandon/bin/current-music"

refreshFrequency: 1000 # ms

render: (output) ->
  "<span>#{output}</span>"

style: """
  -webkit-font-smoothing: antialiased
  color: #666
  font: 14px "Fira Code Retina"
  left: 10px
  top: 2px
  span
    font: 12px "Fira Code Retina"
    color: #D5C4A1
"""

