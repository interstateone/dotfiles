command: """
  icon=$(/Users/brandon/bin/battery-icon)
  percentage=$(/Users/brandon/bin/battery-percentage)
  echo "<span class="icon">$icon</span><span class="percentage">$percentage</span>"
"""

refreshFrequency: 2000 # ms

render: (output) ->
  "bat #{output}"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px "Fira Code Retina"
  top: 2px
  right: 160px
  color: #666
  .percentage
    color: #D5C4A1
  .icon
    font-size: 9px
"""
