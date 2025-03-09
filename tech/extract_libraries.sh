#!/bin/bash

# Set the base directory for ASAP7 CCS libraries
CCS_LIB_DIR="./asap7/LIB/CCS"
EXTRACT_DIR="$CCS_LIB_DIR/extracted_libs"

# Ensure the extraction directory exists
mkdir -p "$EXTRACT_DIR"

# Move into the CCS directory
cd "$CCS_LIB_DIR" || { echo "Error: Cannot access $CCS_LIB_DIR"; exit 1; }

# Extract all .7z library files into extracted_libs
echo "Extracting all .7z files to $EXTRACT_DIR..."
for archive in *.7z; do
    if [[ -f "$archive" ]]; then
        echo "Extracting: $archive..."
        7z x "$archive" -o"$EXTRACT_DIR" || { echo "Error extracting $archive"; exit 1; }
    else
        echo "No .7z files found in $CCS_LIB_DIR"
        exit 1
    fi
done

echo "✅ Extraction complete. Extracted libraries are in: $EXTRACT_DIR"
