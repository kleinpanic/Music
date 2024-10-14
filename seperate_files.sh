#!/bin/bash

# Root directory for extraneous files
EXTRA_DIR="Extranious_files"

# Function to move non-FLAC files
move_extranious_files() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            # Recursively process subdirectories
            move_extranious_files "$file"
        elif [[ "$file" != *.flac && ( "$file" == *.mp3 || "$file" == *.wav || "$file" == *.mp4 || "$file" == *.m4a ) ]]; then
            # Create the corresponding directory structure in Extranious_files
            relative_path="${file#"$PWD/"}"
            dir_path=$(dirname "$relative_path")
            target_dir="$EXTRA_DIR/$dir_path"

            # Create the directory structure if it doesn't exist
            mkdir -p "$target_dir"

            # Move the non-FLAC file to the new directory
            echo "Moving $file to $target_dir"
            mv "$file" "$target_dir/"
        fi
    done
}

# Create the root Extranious_files directory if it doesn't exist
mkdir -p "$EXTRA_DIR"

# Start processing in the current directory
move_extranious_files "$(pwd)"

echo "Separation of FLAC and extraneous files completed."
