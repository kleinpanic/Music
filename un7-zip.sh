#!/bin/bash

# Root directory for uncompressed FLAC files
FLAC_DIR="flac_music"

# Function to extract and splice FLAC files
uncompress_and_splice() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            # Recursively process subdirectories
            uncompress_and_splice "$file"
        elif [[ "$file" == *.7z.001 ]]; then
            # Get the relative path and directory structure
            relative_path="${file#"$PWD/zip_files/"}"
            dir_path=$(dirname "$relative_path")
            target_dir="$FLAC_DIR/$dir_path"

            # Create the corresponding directory structure in flac_music
            mkdir -p "$target_dir"

            # Uncompress and splice the FLAC files
            echo "Uncompressing and splicing $file and its parts to $target_dir"
            7z x "$file" -o"$target_dir"
        fi
    done
}

# Create the root flac_music directory if it doesn't exist
mkdir -p "$FLAC_DIR"

# Start processing in the zip_files directory
uncompress_and_splice "$(pwd)/zip_files"

echo "Uncompression and splicing completed."
