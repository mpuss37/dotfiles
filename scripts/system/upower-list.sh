#!/bin/bash

DMENU_THEME="-nb #1e1e1e -sf #ffffff -sb #8c0007 -nf #ffffff"

# Ambil hanya device battery
devices=$(upower -e | grep battery)

# Mapping: tampilkan device + percentage
menu_list=""
while read -r dev; do
    perc=$(upower -i "$dev" | awk '/percentage/ {print $2}')
    name=$(upower -i "$dev" | awk -F: '/model/ {print $2}' | xargs)
    
    # fallback kalau ga ada nama
    [ -z "$name" ] && name=$(basename "$dev")
    
    menu_list="$menu_list$name ($perc)|$dev\n"
done <<< "$devices"

# Tampilkan ke dmenu
selected=$(echo -e "$menu_list" | dmenu $DMENU_THEME -p "Battery:")

# Exit kalau cancel
[ -z "$selected" ] && exit

# Ambil path device asli
device=$(echo "$selected" | cut -d'|' -f2)

# Ambil detail info
info=$(upower -i "$device" | grep -E "state|percentage|time to")

# Tampilkan hasil
echo "$info" | dmenu $DMENU_THEME -l 5 -p "Info:"
