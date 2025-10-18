#!/bin/bash

# Log stdout and stderr to a file for debugging
exec >>/tmp/hyprlock-debug.log 2>&1
set -x # echo all commands as they run

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY=$(ls /run/user/$(id -u)/ | grep '^wayland-' | grep -v 'lock$' | head -n1)
export XDG_CONFIG_HOME="$HOME/.config"

TMP_DIR="/tmp/hyprlock"
mkdir -p "$TMP_DIR"
IMG="$TMP_DIR/screenlock-wallpaper.png"
IMG_CROPPED="$TMP_DIR/screenlock-wallpaper-350.png"

CURR_WALLPAPER=$(swww query 2>/dev/null | grep "currently displaying" | awk -F'image: ' '{print $2}')

if [[ ! -f "$CURR_WALLPAPER" ]]; then
  echo "[hyprlock-prep] Wallpaper not found or swww failed." >>/tmp/hyprlock-error.log
  exit 1
fi

cp "$CURR_WALLPAPER" "$IMG"
magick "$IMG" -resize 350x350^ -gravity center -extent 350x350 "$IMG_CROPPED"

magick "$IMG" -resize 50% -blur 0x6 "$IMG"
