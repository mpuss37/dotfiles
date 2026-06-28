#!/bin/bash

# Warna tema dmenu
DMENU_OPTS="-p 'Display mode:' -nb '#1e1e1e' -sf '#ffffff' -sb '#8c0007' -nf '#ffffff'"

# Pilihan mode
choice=$(echo -e "PC only\nDuplicate\nExtend\nSecond only" | dmenu $DMENU_OPTS)
[ -z "$choice" ] && exit 0  # Jika user membatalkan

# Deteksi output internal & eksternal
INTERNAL="eDP-1"
EXTERNAL=$(xrandr | grep " connected" | grep -v "$INTERNAL" | awk '{print $1}')

# Flag untuk mengetahui status HDMI
if [ -z "$EXTERNAL" ] || ! xrandr | grep -q "^$EXTERNAL connected"; then
    HDMI_CONNECTED=false
else
    HDMI_CONNECTED=true
fi

# Jalankan sesuai pilihan
case "$choice" in
  "PC only")
    xrandr --output "$EXTERNAL" --off --output "$INTERNAL" --auto
    notify-send "🖥️ Mode: PC only" "Hanya layar internal aktif."
    ;;
  "Duplicate")
    if [ "$HDMI_CONNECTED" = true ]; then
        xrandr --output "$EXTERNAL" --same-as "$INTERNAL" --auto
        notify-send "🖥️ Mode: Duplicate" "Tampilan digandakan ke layar eksternal."
    else
        notify-send "⚠️ HDMI tidak tersambung" "Mode Duplicate dilewati karena tidak ada monitor eksternal."
    fi
    ;;
  "Extend")
    if [ "$HDMI_CONNECTED" = true ]; then
        xrandr --output "$INTERNAL" --auto --output "$EXTERNAL" --right-of "$INTERNAL" --auto
        notify-send "🖥️ Mode: Extend" "Layar eksternal di sebelah kanan."
    else
        notify-send "⚠️ HDMI tidak tersambung" "Mode Extend dilewati karena tidak ada monitor eksternal."
    fi
    ;;
  "Second only")
    if [ "$HDMI_CONNECTED" = true ]; then
        xrandr --output "$INTERNAL" --off --output "$EXTERNAL" --auto
        notify-send "🖥️ Mode: Second only" "Hanya layar eksternal aktif."
    else
        notify-send "⚠️ HDMI tidak tersambung" "Mode Second only dilewati karena tidak ada monitor eksternal."
    fi
    ;;
  *)
    notify-send "❌ Dibatalkan" "Tidak ada mode yang dipilih."
    ;;
esac
