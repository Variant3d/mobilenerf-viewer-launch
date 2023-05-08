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
    #find . -iname "*.png" -exec sh -c 'cwebp  -z 6 -q 100 -alpha_method 1 "{}" -o "${0%.png}.webp"' {} \;
    cd ..
}

# Convert PNGs to lossless WebP for each scene
for scene in "${scenes[@]}"; do
    convert_to_webp $scene
done