command_exists() {
    local command="$1"
    type "$command" >/dev/null 2>&1
}

battery_status() {
    if command_exists "pmset"; then
        pmset -g batt | awk -F '; *' 'NR==2 { print $2 }'
    elif command_exists "upower"; then
        # sort order: attached, charging, discharging
        for battery in $(upower -e | grep battery); do
            upower -i $battery | grep state | awk '{print $2}'
        done | sort | head -1
    elif command_exists "acpi"; then
        acpi -b | grep -oi 'discharging' | awk '{print tolower($0)}'
    fi
}
