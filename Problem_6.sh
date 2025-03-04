#!/usr/bin/bash

csv_file="$1"
modified_file="modified.csv"


cp "$csv_file" "$modified_file"

while true; do
    printf "\nChoose an operation:\n1. Concatenate\n2. Sum\n3. Exit\nEnter your choice: "
    read choice

    if [ "$choice" -eq 1 ]; then
        echo "Enter column numbers to concatenate (comma-separated, e.g., 2,3):"
        IFS=',' read -r col1 col2

        awk -F, -v col1="$col1" -v col2="$col2" -v OFS=',' '
        NR == 1 {
            print $0 ",Concat_c" col1 "_c" col2
        }
        NR > 1 {
            print $0 "," $col1 " " $col2
        }' "$modified_file" > temp.csv 
        mv temp.csv "$modified_file"

        

    elif [ "$choice" -eq 2 ]; then
        echo "Enter column numbers to sum (comma-separated, e.g., 4,5):"
        IFS=',' read -r col1 col2

        awk -F, -v col1="$col1" -v col2="$col2" -v OFS=',' '
        NR == 1 {
            print $0 ",Sum_c" col1 "_c" col2
        }
        NR > 1 {
            sum = ($col1 + $col2);
            print $0 "," sum
        }' "$modified_file" > temp.csv
        mv temp.csv "$modified_file"

        

    elif [ "$choice" -eq 3 ]; then
        echo "Final output saved to '$modified_file'"
        exit 0  # Exit successfully

    else
        echo "Invalid input. Please try again."
    fi
done
