#!/bin/zsh

# process_images.sh
# This script recursively processes image directories:
# 1. Finds all img directories in the source
# 2. Mirrors the directory structure to the target
# 3. For each image:
#    - Copies webp files to target
#    - Converts png files to webp and saves to target
#    - Copies all other files to target
# 4. Renames all webp files in target to png

# Exit on error
set -e

# Display usage information
function usage() {
    echo "Usage: $0 <source_directory> <target_directory>"
    echo "Example: $0 ./godot_docs ./docc_output"
    exit 1
}

# Check if we have required commands
check_commands() {
    local missing_commands=()
    
    # Check for ImageMagick (prefer magick over convert)
    if command -v magick &> /dev/null; then
        CONVERT_CMD="magick"
    elif command -v convert &> /dev/null; then
        CONVERT_CMD="convert"
    else
        missing_commands+=("ImageMagick")
    fi
    
    # Check for find
    if ! command -v find &> /dev/null; then
        missing_commands+=("find")
    fi
    
    if [[ ${#missing_commands[@]} -gt 0 ]]; then
        echo "Error: The following required commands/tools are missing:"
        for cmd in $missing_commands; do
            echo "  - $cmd"
        done
        
        echo ""
        echo "Please install the required dependencies:"
        echo "  - 'ImageMagick': brew install imagemagick"
        exit 1
    fi
}

# Process a single image file
process_image_file() {
    local file=$1
    local target_dir=$2
    
    filename=$(basename "$file")
    extension="${filename##*.}"
    filename_no_ext="${filename%.*}"
    
    # Convert extension to lowercase for comparison (zsh compatible)
    extension_lower=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
    
    case "$extension_lower" in
        webp)
            # 1. Copy webp files to target
            echo "  Copying webp: $filename"
            cp "$file" "$target_dir/$filename"
            ;;
        png)
            # 2. Convert png to webp and save to target
            echo "  Converting png -> webp: $filename"
            $CONVERT_CMD "$file" "$target_dir/$filename_no_ext.webp"
            ;;
        *)
            # 3. Copy other files as-is
            echo "  Copying other: $filename"
            cp "$file" "$target_dir/$filename"
            ;;
    esac
}

# Process a single img directory and its subdirectories
process_img_directory() {
    local src_img_dir=$1
    local target_img_dir=$2
    
    echo "Processing directory: $src_img_dir -> $target_img_dir"
    
    # Create the target directory if it doesn't exist
    mkdir -p "$target_img_dir"
    
    # Process each file and directory in the source img directory
    for item in "$src_img_dir"/*; do
        if [[ -f "$item" ]]; then
            # Process file
            process_image_file "$item" "$target_img_dir"
        elif [[ -d "$item" ]]; then
            # Process subdirectory recursively
            subdir_name=$(basename "$item")
            target_subdir="$target_img_dir/$subdir_name"
            
            echo "  Found subdirectory: $subdir_name"
            process_img_directory "$item" "$target_subdir"
        fi
    done
    
    # Rename all webp files to png in the target directory
    # Enable nullglob to prevent "no matches found" error when no .webp files exist
    setopt nullglob 2>/dev/null || true
    
    # Check if any webp files exist before processing
    webp_files=("$target_img_dir"/*.webp(N))
    if (( ${#webp_files[@]} > 0 )); then
        for webp_file in "${webp_files[@]}"; do
            png_file="${webp_file%.webp}.png"
            echo "  Renaming: $(basename "$webp_file") -> $(basename "$png_file")"
            mv "$webp_file" "$png_file"
        done
    else
        echo "  No webp files to rename in $target_img_dir"
    fi
    
    # Restore original glob behavior
    unsetopt nullglob 2>/dev/null || true
}

# Get relative path (macOS compatible)
get_relative_path() {
    local source="$1"
    local target="$2"
    
    # Convert to absolute paths
    source=$(cd "$source" && pwd)
    target=$(cd "$target" && pwd)
    
    # Get the common prefix
    local common_prefix=""
    local IFS="/"
    local s=($source)
    local t=($target)
    local i=0
    
    while [[ $i -lt ${#s[@]} && $i -lt ${#t[@]} && "${s[$i]}" == "${t[$i]}" ]]; do
        common_prefix="$common_prefix/${s[$i]}"
        ((i++))
    done
    
    # Build the relative path
    local rel_path=""
    local back_steps=$(( ${#s[@]} - i ))
    
    # Go up as needed
    for (( j=0; j<back_steps; j++ )); do
        rel_path="$rel_path../"
    done
    
    # Go down to target
    for (( j=i; j<${#t[@]}; j++ )); do
        rel_path="$rel_path${t[$j]}/"
    done
    
    # Remove trailing slash and return
    echo "${rel_path%/}"
}

# Main function to process all img directories
process_all_img_directories() {
    local source_dir=$1
    local target_dir=$2
    
    # Find all img directories in the source
    find "$source_dir" -type d -name "img" | while read img_dir; do
        # Calculate the relative path from the source to the img directory
        local abs_img_dir=$(cd "$img_dir" && pwd)
        local abs_source_dir=$(cd "$source_dir" && pwd)
        
        # Extract just the part after the source_dir
        local rel_path="${abs_img_dir#$abs_source_dir/}"
        
        # Determine the target path
        target_img_dir="$target_dir/$rel_path"
        
        # Process this img directory
        process_img_directory "$img_dir" "$target_img_dir"
    done
}

# Main script execution
main() {
    # Check for required arguments
    if [[ $# -ne 2 ]]; then
        usage
    fi
    
    SOURCE_DIR="$1"
    TARGET_DIR="$2"
    
    # Check if source directory exists
    if [[ ! -d "$SOURCE_DIR" ]]; then
        echo "Error: Source directory '$SOURCE_DIR' does not exist."
        exit 1
    fi
    
    # Check for required commands and set CONVERT_CMD
    check_commands
    
    # Create target directory if it doesn't exist
    mkdir -p "$TARGET_DIR"
    
    echo "Starting image processing:"
    echo "  Source: $SOURCE_DIR"
    echo "  Target: $TARGET_DIR"
    echo "----------------------------------------"
    
    # Process all img directories
    process_all_img_directories "$SOURCE_DIR" "$TARGET_DIR"
    
    echo "----------------------------------------"
    echo "Image processing complete!"
}

# Run the script
main "$@"
