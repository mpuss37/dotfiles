#!/bin/bash

# Direktori penyimpanan
DIR="/home/mpuss/doc/pictures/ss"
FILENAME="screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"

# Cek apakah direktori sudah ada, jika tidak maka buat
if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
fi

# Buka window untuk menyeleksi area screenshot menggunakan shutter
shutter -s -o "$DIR/$FILENAME" -e

# Kirim notifikasi menggunakan notify-send dengan timeout 4000ms (4 detik)
if [ -f "$DIR/$FILENAME" ]; then
    notify-send -t 6000 "Screenshot Lancar Bos" "$DIR/$FILENAME"
fi

#       -e, --exit_after_capture
#               Exit after the first capture has been made. This is useful when using Shutter in scripts.

#       -n, --no_session
#               Do not add the screenshot to the session. This is useful when using Shutter in scripts.
