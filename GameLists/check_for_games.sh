#!/bin/bash

# Checks to see if all games in the roms dictory exists within the gamelist.xml
# Assumes that you use the roms directory to store the gamelist and not .emulationstation

# Get the current working directory (the ROM directory)
ROM_DIR="$(pwd)"

# Path to the gamelist.xml file
GAMELIST_XML="$ROM_DIR/gamelist.xml"

# Check if gamelist.xml exists
if [ ! -f "$GAMELIST_XML" ]; then
    echo "gamelist.xml not found in $ROM_DIR"
    exit 1
fi

# Loop through each ROM file in the ROM directory
for rom_file in "$ROM_DIR"/*; do
    # Skip if it's a directory
    [ -d "$rom_file" ] && continue

    # Get the file extension and basename
    file_extension="${rom_file##*.}"
    rom_name=$(basename "$rom_file")

    # Check if the file is a .state or .srm file
    if [[ "$rom_name" == *.state* || "$rom_name" == *.srm || "$rom_name" == *.cfg || "$rom_name" == *.xml ]]; then
        continue
    fi

    # Check if the ROM is in the gamelist.xml
    if ! fgrep -q "<path>./$rom_name</path>" "$GAMELIST_XML"; then
        echo "Game missing from gamelist.xml: $rom_name"
    fi
done