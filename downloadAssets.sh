#!/bin/bash

# Base URL
base_url="https://storage.googleapis.com/jax3d-public/projects/mobilenerf/mobilenerf_viewer_mac/"

# Scene names
scenes=("chair" "drums" "hotdog" "lego" "mic" "ship" "fern" "flower" "fortress" "horns" "leaves" "orchids" "room" "trex" "bicycle" "gardenvase" "stump")

# Download function
download_files() {
    scene_name=$1
    mkdir -p $scene_name
    cd $scene_name

    # Download MLP JSON
    curl -O ${base_url}${scene_name}_mac/mlp.json

    # Get obj_num from MLP JSON
    obj_num=$(jq '.obj_num' mlp.json)

    # Download PNGs and OBJs
    for ((i=0; i<$obj_num; i++)); do
        for ((feat=0; feat<2; feat++)); do
            curl -O ${base_url}${scene_name}_mac/shape${i}.pngfeat${feat}.png
        done
        for ((j=0; j<8; j++)); do
            curl -O ${base_url}${scene_name}_mac/shape${i}_${j}.obj
        done
    done

    cd ..
}

# Download files for each scene
for scene in "${scenes[@]}"; do
    download_files $scene
done
