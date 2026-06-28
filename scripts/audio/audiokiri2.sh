#!/bin/bash

# Mendapatkan sink aktif dan state running dengan nama bluez_sink.41_42_24_DF_AF_34.a2dp_sink
SINK=$(pactl list sinks | grep -B 1 "State: RUNNING" | grep "Name: bluez_sink.41_42_24_DF_AF_34.a2dp_sink" | awk '{print $2}')

if [ "$SINK" == "bluez_sink.41_42_24_DF_AF_34.a2dp_sink" ]; then
    echo "Sink aktif: $SINK"

    # Mendapatkan volume channel kiri dan kanan saat ini
    LEFT_VOLUME=$(pactl list sinks | grep -A 15 "Name: $SINK" | grep "Volume:" | head -1 | awk '{print $5}' | tr -d '%')
    RIGHT_VOLUME=$(pactl list sinks | grep -A 15 "Name: $SINK" | grep "Volume:" | head -1 | awk '{print $12}' | tr -d '%')

    echo "Volume kiri: $LEFT_VOLUME%"
    echo "Volume kanan: $RIGHT_VOLUME%"

    # Menambah 10% ke channel kiri dan kanan (maks 150%)
    NEW_LEFT_VOLUME=$((LEFT_VOLUME + 10))
    NEW_RIGHT_VOLUME=$((RIGHT_VOLUME + 10))

    if [ $NEW_LEFT_VOLUME -gt 400 ]; then
        NEW_LEFT_VOLUME=40
    fi

    if [ $NEW_RIGHT_VOLUME -gt 400 ]; then
        NEW_RIGHT_VOLUME=40
    fi

    # Atur volume channel kiri dan kanan
    pactl set-sink-volume "$SINK" ${NEW_LEFT_VOLUME}% ${NEW_RIGHT_VOLUME}%
    echo "Volume diatur ke kiri: ${NEW_LEFT_VOLUME}%, kanan: ${NEW_RIGHT_VOLUME}%"
else
    echo "Sink bukan bluez_sink.41_42_24_DF_AF_34.a2dp_sink. Menggunakan logika asli."

    # Mendapatkan sink default
    SINK=$(pactl info | grep "Default Sink" | cut -d ' ' -f3)

    # Mendapatkan volume channel kiri saat ini
    LEFT_VOLUME=$(pactl list sinks | grep -A 15 "Name: $SINK" | grep "Volume:" | head -1 | awk '{print $5}' | tr -d '%')
    echo "Sink default: $SINK"
    echo "Volume kiri: $LEFT_VOLUME%"

    # Menambah 10% ke channel kiri (maks 150%)
    NEW_LEFT_VOLUME=$((LEFT_VOLUME + 10))
    if [ $NEW_LEFT_VOLUME -gt 400 ]; then
        NEW_LEFT_VOLUME=400
    fi

    # Atur volume channel kiri (kiri: NEW_LEFT_VOLUME%, kanan: 0%)
    pactl set-sink-volume "$SINK" ${NEW_LEFT_VOLUME}% 0%
    echo "Volume diatur ke kiri: ${NEW_LEFT_VOLUME}%, kanan: 0%"
fi

