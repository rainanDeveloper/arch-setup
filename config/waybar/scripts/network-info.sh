#!/bin/bash

# Get the active interface (this checks both Wi-Fi and Wired)
INTERFACE=$(ip link show | grep 'state UP' | awk '{print $2}' | sed 's/://')

# Default values
NETWORK_ICON=""
SSID="Disconnected"
IP="No IP"
DOWN_MB="0"
UP_MB="0"

if [[ -n "$INTERFACE" ]]; then
  # Get IP address for the interface
  IP=$(ip -4 addr show "$INTERFACE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' || echo "No IP")

  # Check if it's a Wi-Fi connection
  if [[ $(iw dev | grep 'type managed') ]]; then
    # For Wi-Fi, get the SSID and signal strength
    SSID=$(iw dev "$INTERFACE" link | grep SSID | awk -F ': ' '{print $2}')
    NETWORK_ICON="" # Wi-Fi icon
    # Get download/upload speeds
    DOWNLOAD=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
    UPLOAD=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
    DOWN_RATE=$(awk "BEGIN {print $DOWNLOAD/1024/1024}")
    UP_RATE=$(awk "BEGIN {print $UPLOAD/1024/1024}")
  else
    # For wired, just set a generic wired icon
    NETWORK_ICON="" # Wired icon
    SSID="Wired"
    DOWN_RATE=0
    UP_RATE=0
  fi
fi
# Output JSON for Waybar
echo "{\"text\": \" $NETWORK_ICON \", \"tooltip\": \"SSID: $SSID\nIP: $IP\n↓ $DOWN_MB MB\n↑ $UP_MB MB\"}"
