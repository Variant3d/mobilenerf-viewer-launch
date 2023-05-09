#!/bin/bash

# Scene names
scenes=("bicycle" "drums" "horns" "trex" "gardenvase" "stump")
#scenes=("stump")

# Conversion function
convert_to_webp() {
    scene_name=$1
    cd $scene_name

    # Find all PNG files and convert them to lossless WebP
     find . -iname "*.png" -exec sh -c 'cwebp  -lossless "{}" -z 9 -o "${0%.png}.webp"' {} \;

    # Find all PNG files, resize them to half resolution (2048x2048) and convert them to lossless WebP with "_lores" added to the filename
    find . -iname "*.png" -exec sh -c 'convert "{}" -resize 2048x2048 -filter point "${0%.png}_lores.png"' {} \;
    find . -iname "*_lores.png" -exec sh -c 'cwebp -lossless "{}" -z 9 -o "${0%.png}.webp"' {} \;
    # Delete the temporary half-resolution PNG files
    find . -iname "*_lores.png" -exec rm {} \;

    cd ..
}

# Convert PNGs to lossless WebP for each scene
for scene in "${scenes[@]}"; do
    convert_to_webp $scene
done