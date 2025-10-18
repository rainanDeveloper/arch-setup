#!/bin/bash

CURR_WALLPAPER=$(swww query | grep "currently displaying" | awk -F'image: ' '{print $2}')

TMP_DIR="/tmp/swaylock"
mkdir -p "$TMP_DIR"
IMG="$TMP_DIR/screenlock-wallpaper.png"

# Copy screenlock-wallpaper
cp "$CURR_WALLPAPER" "$IMG"
