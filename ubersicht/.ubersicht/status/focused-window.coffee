command: "echo $(/usr/local/bin/kwmc query space active tag)"

refreshFrequency: 500 # ms

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px "Fira Code Retina"
  left: 10px
  top: 2px
  width: 30%
  height: 20px
  color: #D5C4A1
  overflow: hidden
  text-overflow: ellipsis
  white-space: no-wrap
"""
