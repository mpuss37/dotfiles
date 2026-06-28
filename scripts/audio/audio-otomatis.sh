        tes=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
        digit_1=$(echo "$tes" | cut -c1)
        digit_2=$(echo "$tes" | cut -c2)
    while [ "$digit_2" == "9" ]; do
        tes=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
        digit_1=$(echo "$tes" | cut -c1)
        digit_2=$(echo "$tes" | cut -c2)

        if [ "$digit_2" == "9" ]; then
            	pactl set-sink-volume @DEFAULT_SINK@ "${digit_1}0%"
        fi

        sleep 1
    done &
