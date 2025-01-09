#!/bin/bash

# File name for the student data
file="LCP_22-23_students.csv"

# Check if file exists
if [ ! -f "$file" ]; then
    echo "File not found!"
    exit 1
fi

# Print the path of the file to confirm it is correct
echo "Using file: $file"

# Loop through the letters of the alphabet
for letter in {A..Z}
do
    # Count how many surnames start with this letter
    count=$(grep -i "^$letter" "$file" | wc -l)

    # Print the result
    echo "$letter: $count"
done

