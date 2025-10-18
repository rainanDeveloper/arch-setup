#!/usr/bin/env bash
vol=$(pamixer --get-volume)
muted=$(pamixer --get-mute)

if [ "$muted" = "true" ]; then
  echo "󰝟 Muted"
else
  if [ "$vol" -ge 75 ]; then
    echo " $vol%"
  elif [ "$vol" -ge 50 ]; then
    echo " $vol%"
  else
    echo " $vol%"
  fi

fi
