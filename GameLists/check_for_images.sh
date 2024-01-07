#!/bin/bash

# Checks to make sure that rom actually has the image it claims to link to in the gamelist
# OR that it doesn't have an image linked
# Assumes skyscraper directory is utilized

# Get the current working directory (the ROM directory)
ROM_DIR="$(pwd)"

# Path to the gamelist.xml file
GAMELIST_XML="$ROM_DIR/gamelist.xml"

# Path to the screenshots directory (assuming a standard RetroPie structure)
IMAGE_DIR="$ROM_DIR/media/screenshots"

# Check if gamelist.xml exists
if [ ! -f "$GAMELIST_XML" ]; then
    echo "gamelist.xml not found in $ROM_DIR"
    exit 1
fi

# Extract screenshot paths from the gamelist.xml and check each one
grep "<image>" "$GAMELIST_XML" | sed 's/.*<image>\(.*\)<\/image>.*/\1/' | while read -r image_path; do
    # Construct the full path
    full_image_path="$IMAGE_DIR/${image_path##*/}"

    # Check if the image file exists
    if [ ! -f "$full_image_path" ]; then
        echo "Image missing: $full_image_path"
    fi
done

# Check for blank or missing image tags
grep -oP '<game>(.*?)(?=<\/game>)' "$GAMELIST_XML" | grep -v "<image>" | grep -oP '(?<=<name>).*?(?=</name>)' | while read -r game_name; do
    echo "Image tag missing or empty for game: $game_name"
done