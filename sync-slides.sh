#!/bin/bash

# Configuration: Source and Destination Roots
SOURCE_ROOT="slides"
DEST_ROOT="docs/slides"

# Error handling: Exit if source root does not exist
if [ ! -d "$SOURCE_ROOT" ]; then
    echo "Error: Directory '$SOURCE_ROOT' not found."
    exit 1
fi

echo "Starting synchronization of speaker slides..."

# Iterate through each subdirectory in the source root
for dir_path in "$SOURCE_ROOT"/*/; do
    
    # Check if the glob matched anything (prevents copying literal filenames)
    [ -e "$dir_path" ] || continue

    # Extract the subfolder name from the path
    subdir=$(basename "$dir_path")
    
    # Define source and destination file paths with proper quoting
    src_file="$SOURCE_ROOT/$subdir/index-speaker.html"
    dest_dir="$DEST_ROOT/$subdir"
    dest_file="$dest_dir/index-speaker.html"

    # Check if the speaker HTML file exists in the subdirectory
    if [ -f "$src_file" ]; then
        echo "Found: $src_file"
        
        # Create destination directory structure if it doesn't exist
        mkdir -p "$dest_dir"
        
        # Copy the file preserving permissions (optional flag) and overwriting existing
        cp "$src_file" "$dest_file"
        
        echo "Copied to: $dest_file"
    else
        echo "Skipping: No index-speaker.html found in '$subdir'"
    fi

done

echo "Synchronization complete."
