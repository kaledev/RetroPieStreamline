# Converts all 444 encoded videos to 420 for playback on RetroPie
# Saves in-place and will overwrite without warning, can be run in any directory
for f in *.mp4; do
    echo "Processing file: $(pwd)/$f"

    if ffprobe "$f" 2>&1 | grep -qE 'yuv444p|yuvj444p'; then
        temp_file="temp_$f"
        echo "Converting to 4:2:0..."
        ffmpeg -i "$f" -y -pix_fmt yuv420p -c:v libx264 -strict experimental "$temp_file" && mv "$temp_file" "$f"
    else
        echo "File is not in 4:4:4 format, skipping: $f"
    fi
done