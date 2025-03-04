#!/usr/bin/bash

csv_file="$1"
column_num="$2"

read a b c <<< $(awk -F, -v col="$column_num" 'NR<=3 {print $col}' "$csv_file" | tr '\n' ' ')


if [ $((a + c)) -eq $((2 * b)) ]; then
    echo "Enter the number of additional rows to generate:"
    read rows

    common_diff=$((b - a))
    last_value=$c

    
    for ((i=1; i<=rows; i++)); do
        last_value=$((last_value + common_diff))
        awk -F, -v OFS=',' -v col="$column_num" -v val="$last_value" '
        {
            for (i=1; i<=NF; i++) {
                if (i == col) printf "%s%s", val, (i==NF ? "" : OFS)
                else printf "%s%s", "", (i==NF ? "" : OFS)
            }
            print ""
        }' >> "$csv_file"
    done

    echo "CSV file extended successfully."
    cat "$csv_file"
else
    echo "First three numbers in the specified column are not in AP. Exiting..."
    exit -1
fi
