#!/bin/bash

current_dir=$(pwd)
target_string="sudo snap"

comment_the_line() {
    line=$1
    file=$2
    # comment the line in the file
    sed -i "s|$line|#$line|g" $file
}

read_file() {
    file_path=$1
    while IFS= read -r line; do
        if [[ $line == *"$target_string"* ]]; then
            comment_the_line "$line" "$file_path"
        fi
    done < "$file_path"
}

walk_the_directory() {
    find "$current_dir" -type f -name "*.sh" | while IFS= read -r file; do
        if [[ $file == *"remove_snaps.sh"* ]]; then
            continue
        fi
        read_file "$file"
    done
}

walk_the_directory