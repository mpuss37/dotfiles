#!/bin/bash

# Mendapatkan sink aktif
SINK=$(pactl info | grep "Default Sink" | cut -d ' ' -f3)

# Mendapatkan volume channel kiri saat ini
LEFT_VOLUME=$(pactl list sinks | grep -A 15 "Name: $SINK" | grep "Volume:" | head -1 | awk '{print $5}' | tr -d '%')
echo $SINK
echo $LEFT_VOLUME

# Menambah 10% ke channel kiri (maks 150%)
NEW_LEFT_VOLUME=$((LEFT_VOLUME + 10))
if [ $NEW_LEFT_VOLUME -gt 300 ]; then
    NEW_LEFT_VOLUME=300
fi

# Atur volume channel (kiri: NEW_LEFT_VOLUME%, kanan: 0%)
pactl set-sink-volume "$SINK" ${NEW_LEFT_VOLUME}% 0%
