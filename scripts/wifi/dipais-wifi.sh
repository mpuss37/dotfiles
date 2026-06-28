dipais=$(ip link | awk -F': ' '/^[0-9]+: / {print $2}' | dmenu -i -fn 'JetBrainsMono ExtraBold-14' -nb '#781913' -sb '#E00000' -p "Interface :" -l 5 | cut -d' ' -f3)

if [ "$dipais" = "$dipais" ]; then
echo $dipais > /home/mpuss/kodingan/skrip/dipais-wifi.txt
sudo ip link set $dipais up
sudo ifconfig $dipais up
notify-send --icon="" -t 5000 -h string:fgcolor:#FFFFFF -h string:bgcolor:#E00000 "$dipais murup"
else
notify-send --icon="" -t 5000 -h string:fgcolor:#FFFFFF -h string:bgcolor:#E00000 "$dipais turuh"
fi
