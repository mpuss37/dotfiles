#!/bin/sh

# ambil URL dari handler
URL="$1"

# buang prefix ytdlp:
FIXURL="${URL#ytdlp:}"

# folder download
OUTDIR="$HOME/"

yt-dlp "$FIXURL" \
  -o "$OUTDIR/%(title)s.%(ext)s"
