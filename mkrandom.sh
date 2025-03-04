#! /usr/bin/bash

echo "Enter the number of files to be generated: "
read numFiles
echo "Enter the size of each file in bytes: "
read fileSize

create_file(){
    local file_name="$1"
    local file_size="$2"
    # Generate random content using /dev/urandom and base64. 
    head -c "$file_size" < /dev/urandom | base64 > "$file_name"
}

if ! [[ "$numFiles" =~ ^[0-9]+$ ]] || ! [[ "$fileSize" =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid Input"
    exit 1
fi 

for((i=1;i<=numFiles;i++)); do
    created_file="random_file$i.txt"
    create_file "$created_file" "$fileSize"
    echo "Created a random file $created_file with random content of size $fileSize bytes"
done

