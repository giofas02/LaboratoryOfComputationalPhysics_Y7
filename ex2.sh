#!/bin/bash

# Initialize variables to keep track of the maximum count and the corresponding letter
max_count=0
max_letter=""

# Iterate over each line in the counts.txt file
while IFS=": " read -r letter count
do
    # Compare the current count with the max count
    if [ "$count" -gt "$max_count" ]; then
        max_count="$count"
        max_letter="$letter"
    fi
done < counts.txt

# Print the letter with the most counts
echo "The letter with the most counts is: $max_letter with $max_count occurrences"

