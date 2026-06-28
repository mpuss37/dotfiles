#!/bin/bash

url="https://allmanga.to/search-anime?tr=sub&cty=ALL&query=naruto"
output_file="output.html"

# Menggunakan curl untuk mengambil konten HTML dari URL
html_content=$(curl -s "$url")

# Menyimpan konten HTML ke dalam file
echo "$html_content" > "$output_file"

echo "Konten HTML telah disimpan ke dalam file $output_file"
