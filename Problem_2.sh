#!/usr/bin/bash

echo "Enter the file extension for the files to be renamed in the current directory
(for eg. , txt,c,cpp,py): "
read extension

echo "Enter the prefix to be prepended to the file name (press Enter for current date): "
read prefix

default_prefix=$(date +"%Y-%m-%d")

if [ -z "$prefix" ]; then
    prefix="$default_prefix"
fi

for file in *.$extension; do
    if [ -f "$file" ]; then
        old_file_name="$file"
        new_file_name="${prefix}-${file}"
        mv "$old_file_name" "$new_file_name"
        echo "Old file name: $old_file_name"
        echo "New file name: $new_file_name"
        printf "\n\n"
    fi
done
