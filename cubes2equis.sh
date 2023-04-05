#!/bin/bash

# Path to the directory to search
dir="$1"

# Iterate over each cubemap file
while read -r file; do
  # Get the file width and height using the "file" command
  file_info=$(file "$file")
  echo $file_info

  width=$(echo "$file_info" | grep -oP ', \K\d+(?= x \d+)')
#  height=$(echo "$file_info" | grep -oP ', \d+ x \K\d+')
 
  # equis are as width as the cube, and height shoudl be 0.5
  height=$((width/2))
  #echo $width " x " $height

  # Call the Node.js script to convert the file to equirectangular format
  output_file="${file%.*}_equi.png"
  time node index.js -i "$file" -w "$width" -h "$height" -o "$output_file"
done < <(find "$dir" -type f -iname "*cubemap.png")

echo "Done"
