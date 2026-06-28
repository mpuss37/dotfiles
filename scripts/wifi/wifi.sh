#bssid=$(nmcli device wifi list | sed -n '1!p' | cut -b 9- | dmenu -i -fn 'JetBrainsMono ExtraBold-14' -nb '#781913' -sb '#E00000' -p "Wifi :" -l 5 | cut -d' ' -f1)
dipais=$(cat /home/mpuss/kodingan/skrip/dipais-wifi.txt)
namawifi=$(nmcli device wifi show-password ifname $dipais | grep SSID | cut -d ':' -f 2- | cut -c2-)
passwordhiswifi=$(nmcli device wifi show-password ifname $dipais | grep Password | cut -d ':' -f 2- | cut -c2-)
if [ "$namawifi" = "" ];
then
namawifi="kosong"
ssid=$(nmcli device wifi list ifname $dipais | sed -n '1!p' | cut -b 9- | dmenu -i -fn 'JetBrainsMono ExtraBold-14' -nb '#781913' -sb '#E00000' -p "$dipais $namawifi :$passwordhiswifi" -l 5 | cut -d' ' -f1)
else
#namawifi="kosong"
#ssid=$(nmcli device wifi list ifname $dipais | sed -n '1!p' | cut -b 9- | dmenu -i -fn 'JetBrainsMono ExtraBold-14' -nb '#781913' -sb '#E00000' -p "$dipais $namawifi :" -l 5 | cut -d' ' -f2)
namawifi=$(nmcli device wifi show-password ifname $dipais | grep SSID | cut -d ':' -f 2- | cut -c2-)
ssid=$(nmcli device wifi list ifname $dipais | sed -n '1!p' | cut -b 9- | dmenu -i -fn 'JetBrainsMono ExtraBold-14' -nb '#781913' -sb '#E00000' -p "$dipais $namawifi : $passwordhiswifi" -l 5 | cut -d' ' -f1)
fi
#nmcli connection down $namawifi

mari=false
kosong=""
if [ "$ssid" != "" ];
then
while [ "$mari" = false ]; do

pass=$(nmcli device wifi connect $ssid password ifname $dipais | dmenu -i -fn 'JetBrainsMono ExtraBold-14' -nb '#781913' -sb '#E00000' -p "$dipais $ssid : $kosong")
panjang_pass=${#pass}
if [ "$pass" = "" ];
then
notify-send --icon="" -t 5000 -h string:fgcolor:#FFFFFF -h string:bgcolor:#E00000 "$dipais $ssid gagal-konek"
echo "bener"
mari=true
elif [ "$panjang_pass" -le 7 ];
then
kosong="ngelu"
echo "keliru"
notify-send --icon="" -t 5000 -h string:fgcolor:#FFFFFF -h string:bgcolor:#E00000 "$dipais $ssid gagal-konek"
else
echo "bener"
mari=true
fi
done
nmcli device wifi connect $ssid password $pass ifname $dipais
notify-send --icon="" -t 5000 -h string:fgcolor:#FFFFFF -h string:bgcolor:#E00000 "$dipais $ssid konek"
fi
fi
#notify-send --icon="firefox" -t 5000 -h string:fgcolor:#FFFFFF -h string:bgcolor:#E00000 "$dipais $ssid konek"
