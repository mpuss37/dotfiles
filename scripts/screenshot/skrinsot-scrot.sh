#!/bin/bash

# Direktori penyimpanan
DIR="/home/mpuss/doc/pictures/ss"
FILENAME="screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"

# Cek apakah direktori sudah ada, jika tidak maka buat
if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
fi

# Ambil screenshot menggunakan scrot dan simpan di direktori yang ditentukan
scrot --delay 1 "$DIR/$FILENAME"

# Kirim notifikasi menggunakan notify-send dengan timeout 4000ms (4 detik)
if [ -f "$DIR/$FILENAME" ]; then
    xclip -selection clipboard -t image/png -i "$DIR/$FILENAME"
    notify-send -t 6000 "Screenshot Lancar Bos" "$DIR/$FILENAME"
else
    notify-send -t 6000 "Screenshot Remek Bos!" "Ojok lali berdoa sebelum aktivitas."
fi
