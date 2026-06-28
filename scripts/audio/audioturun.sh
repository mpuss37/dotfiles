#!/bin/bash
tes=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
if [ $tes != 10 ]
#if [[ $tes != 30 ]]
then
        pactl set-sink-volume @DEFAULT_SINK@ -6% && $refresh_i3status
fi
