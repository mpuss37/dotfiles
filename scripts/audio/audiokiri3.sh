#!/bin/bash

# Mendapatkan sink bluetooth yang aktif
SINK=$(pactl list sinks | grep -B 1 "State: RUNNING" | grep "Name: bluez_sink" | awk '{print $2}')

if [[ -n "$SINK" ]]; then
    echo "Sink bluetooth aktif: $SINK"

    # Mendapatkan volume saat ini dari sink bluetooth
    tes=$(pactl list sinks | grep -A 15 "Name: $SINK" | grep '^[[:space:]]Volume:' | head -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

    if [[ $tes != 120 ]]; then
        pactl set-sink-volume "$SINK" +5% && $refresh_i3status
        echo "Volume bluetooth dinaikkan 5%."
    else
        echo "Volume bluetooth sudah mencapai 120%."
    fi
else
    echo "Tidak ada sink bluetooth yang aktif."
fi
