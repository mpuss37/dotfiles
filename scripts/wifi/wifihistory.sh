#!/bin/bash

# Deklarasi dua variabel
angka1=10
angka2=20

# Membandingkan dua variabel
if [ $angka1 -eq $angka2 ]; then
    echo "Angka 1 sama dengan Angka 2"
elif [ $angka1 -lt $angka2 ]; then
    echo "Angka 1 lebih kecil dari Angka 2"
else
    echo "Angka 1 lebih besar dari Angka 2"
fi
