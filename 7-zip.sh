#!/bin/bash

# Root directory for zip files
ZIP_DIR="zip_files"
MAX_SIZE=100M # Maximum size of each split part

# Function to process and zip FLAC files
process_flac_files() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            # Skip .git and Extranious_files directories
            if [[ "$file" != *".git"* && "$file" != *"zip_files" && "$file" && "$file" != *"Extranious_files"* ]]; then
                process_flac_files "$file"
            fi
        elif [[ "$file" == *.flac ]]; then
            # Get relative path and directory structure
            relative_path="${file#"$PWD/"}"
            dir_path=$(dirname "$relative_path")
            target_dir="$ZIP_DIR/$dir_path"

            # Create the corresponding directory structure in zip_files
            mkdir -p "$target_dir"

            # 7-zip the file
            echo "Compressing $file"

            # Split the file if it's bigger than 100MB, otherwise just compress
            7z a -v$MAX_SIZE -t7z "$target_dir/$(basename "$file" .flac).7z" "$file"
        fi
    done
}

# Create the root zip_files directory if it doesn't exist
mkdir -p "$ZIP_DIR"

# Start processing in the current directory
process_flac_files "$(pwd)"

echo "Compression and splitting completed."

