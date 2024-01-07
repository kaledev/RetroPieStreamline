#!/bin/bash

# Get the current working directory (the ROM directory)
ROM_DIR="$(pwd)"

# Path to the gamelist.xml file
GAMELIST_XML="$ROM_DIR/gamelist.xml"

# Path to the video directory (assuming a standard RetroPie structure)
VIDEO_DIR="$ROM_DIR/media/videos"

# Check if gamelist.xml exists
if [ ! -f "$GAMELIST_XML" ]; then
    echo "gamelist.xml not found in $ROM_DIR"
    exit 1
fi

# Extract video paths from the gamelist.xml and check each one
grep "<video>" "$GAMELIST_XML" | sed 's/.*<video>\(.*\)<\/video>.*/\1/' | while read -r video_path; do
    # Construct the full path
    full_video_path="$VIDEO_DIR/${video_path##*/}"

    # Check if the video file exists
    if [ ! -f "$full_video_path" ]; then
        echo "Video missing: $full_video_path"
    fi
done
