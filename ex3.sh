#!/bin/bash

# File name for the student data
file="LCP_22-23_students.csv"

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "File not found!"
    exit 1
fi

# Sort the file alphabetically
sorted_file="sorted_students.csv"
sort "$file" > "$sorted_file"

# Loop over the sorted file and group students modulo 18
for ((i = 1; i <= 18; i++)); do
    # Create a file for each group
    group_file="group_${i}.csv"
    touch "$group_file"

    # Loop through each student in the sorted file and assign them to a group
    awk -v group="$i" 'NR % 18 == group' "$sorted_file" > "$group_file"
    
    echo "Group $i saved in $group_file"
done

echo "Grouping complete."

