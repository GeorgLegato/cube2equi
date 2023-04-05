#!/bin/bash

# Path to the subfolder containing the folders with the tile files
path_to_subfolder="$1"

for f in "$path_to_subfolder"/*/; do
  # Get the name of the folder
  foldername=$(basename "$f")
  OUTNAME="$path_to_subfolder$f/$foldername""_cubemap.png"
  echo "$OUTNAME"

  # create empty-white in current tile size
  magick -size $(magick identify -format "%wx%h" "$f/up.*") xc:white "$f/e.png"

magick montage \
"$f/e.png" "$f/up.*"    "$f/e.png"    "$f/e.png"  \
"$f/left.*" "$f/front.*" "$f/right.*"  "$f/back.*" \
"$f/e.png" "$f/down.*"  "$f/e.png"    "$f/e.png" \
-tile 4x3 -geometry +0+0 -background none  "$OUTNAME"
done
