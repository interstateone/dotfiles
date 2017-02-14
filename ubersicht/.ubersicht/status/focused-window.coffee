command: """
spaces=$(/usr/local/bin/kwmc query space list | cut -d, -f2 | paste -sd "," -)
current_space_id=$(/usr/local/bin/kwmc query space active id)
printf '{\
  "spaces": "%s",\
  "currentSpaceId": %s\
}' "$spaces" "$current_space_id"
"""

refreshFrequency: 1000 # ms

render: (output) ->
  json = JSON.parse(output)
  spaces = json.spaces.split(", ").map (s) -> s.trim()
  output = "<ul>"
  output += "<li class=\"#{if spaceIndex is json.currentSpaceId - 1 then "current" else ""}\">#{space}</li>" for space, spaceIndex in spaces
  output += "</ul>"
  return output

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
  ul
    margin: 0
    padding: 0
  li
    display: inline-block
    padding: 0 4px

    &.current
      background-color: #D5C4A1
      color: black
"""
