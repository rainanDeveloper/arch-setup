#!/bin/bash

DATE=$(date '+%d/%m/%Y')
TIME=$(date '+%H:%M')
DAY=$(date +%-d)
CAL=$(cal | sed "s|\b$DAY\b|<span background='#FFFFFF' foreground='#131a28'>$DAY</span>|")

# Escape newlines for JSON tooltip
CAL_ESCAPED=$(echo "$CAL" | sed ':a;N;$!ba;s/\n/\\n/g')

echo "{\"text\": \" $DATE,  $TIME\", \"tooltip\": \"$CAL_ESCAPED\"}"
