#!/bin/bash

# Function to check and convert files to FLAC
convert_to_flac() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            # Recursively go into directories
            convert_to_flac "$file"
        elif [[ "$file" == *.zip ]]; then
            # Skip ZIP files
            echo "Skipping zip file: $file"
        elif [[ "$file" == *.mp3 || "$file" == *.wav || "$file" == *.mp4 || "$file" == *.m4a ]]; then
            # Get base filename without extension
            base="${file%.*}"
            # Convert to FLAC
            echo "Converting $file to $base.flac"
            ffmpeg -i "$file" "$base.flac"
        else
            echo "Not an audio/video file, skipping: $file"
        fi
    done
}

# Start conversion in the Extranious_files directory
if [ -d "Extranious_files" ]; then
    convert_to_flac "$(pwd)/Extranious_files"
    echo "Conversion completed."
else
    echo "Extranious_files directory not found!"
fi
