#!/bin/bash
WALL_DIR="$HOME/wallpapers"
TRANSITIONS=("simple" "fade" "left" "right" "top" "bottom" "wipe" "grow" "center" "outer" "random" "wave")

# pick random wallpaper
IMG=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n1)

# pick random transition
TRANSITION=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}

# apply
swww img "$IMG" --transition-type "$TRANSITION" --transition-duration 3
