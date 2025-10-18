#!/bin/bash

# Path to battery info
UPOWER_BAT_PATH=$(upower -e | grep battery)
BAT_PATH="/sys/class/power_supply/BAT1"

TIME=$(upower -i $UPOWER_BAT_PATH | grep 'time to' | awk -F: '{print $2}' | xargs)

# Get current status and percent
STATUS=$(cat "$BAT_PATH/status")
PERCENT=$(cat "$BAT_PATH/capacity")

TTA_MESSAGE=""

if [[ "$STATUS" == "Charging" ]]; then
  TTA_MESSAGE="- time to full: $TIME"
elif [[ "$STATUS" == "Discharging" ]]; then
  TTA_MESSAGE="- time remaining: $TIME"
fi

# Pick icon based on status and charge level
if [[ "$STATUS" == "Charging" || "$STATUS" == "Full" ]]; then
  ICON="󰢝" # Plug/charging icon
else
  if [ "$PERCENT" -ge 90 ]; then
    ICON="󰁹"
  elif [ "$PERCENT" -ge 80 ]; then
    ICON="󰂂"
  elif [ "$PERCENT" -ge 70 ]; then
    ICON="󰂀"
  elif [ "$PERCENT" -ge 60 ]; then
    ICON="󰂀"
  elif [ "$PERCENT" -ge 50 ]; then
    ICON="󰁿"
  elif [ "$PERCENT" -ge 40 ]; then
    ICON="󰁽"
  elif [ "$PERCENT" -ge 30 ]; then
    ICON="󰁼"
  elif [ "$PERCENT" -ge 20 ]; then
    ICON="󰁻"
  else
    ICON="󰁺"
  fi
fi

# Output JSON for Waybar
echo "{\"text\": \"$ICON $PERCENT%\", \"tooltip\": \"$STATUS — $PERCENT% $TTA_MESSAGE\"}"
