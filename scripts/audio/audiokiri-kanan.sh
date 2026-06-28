#!/bin/bash

# Nama sink TWS / Bluetooth
BT_SINK="bluez_sink.41_42_24_DF_AF_34.a2dp_sink"

# Ambil default sink aktif
SINK=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')

echo "Sink aktif: $SINK"

# Ambil volume kiri & kanan
read LEFT_VOLUME RIGHT_VOLUME <<< $(
    pactl list sinks |
    awk -v sink="$SINK" '
        $0 ~ "Name: "sink {found=1}
        found && /Volume:/ {
            gsub(/%/, "", $5)
            gsub(/%/, "", $12)
            print $5, $12
            exit
        }
    '
)

# Tambah volume
STEP=6
MAX=400

NEW_LEFT=$((LEFT_VOLUME + STEP))
NEW_RIGHT=$((RIGHT_VOLUME + STEP))

[ $NEW_LEFT -gt $MAX ] && NEW_LEFT=$MAX
[ $NEW_RIGHT -gt $MAX ] && NEW_RIGHT=$MAX

if [[ "$SINK" == bluez_sink.* ]]; then
    echo "🎧 TWS / Bluetooth terdeteksi → stereo aktif"

    pactl set-sink-volume "$SINK" ${NEW_LEFT}% ${NEW_RIGHT}%
    echo "Volume → kiri: ${NEW_LEFT}% | kanan: ${NEW_RIGHT}%"

else
    echo "💻 Speaker laptop → mono kiri"

    pactl set-sink-volume "$SINK" ${NEW_LEFT}% 0%
    echo "Volume → kiri: ${NEW_LEFT}% | kanan: 0%"
fi
