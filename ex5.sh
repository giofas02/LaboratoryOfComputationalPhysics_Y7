#!/bin/bash

# Set the number of copies
n_copies=3

# Loop
for ((i=1; i<=n_copies; i++)); do
  # Output file name
  output_file="data_copy_$i.txt"

  # Clear the output file if it already exists
  > "$output_file"

  # Process the file and divide each number by i
  while read -r line; do
    for word in $line; do
      result=$(echo "scale=5; $word / $i" | bc -l)
      echo "$result" >> "$output_file"
    done
  done < data.txt

  # Inform the user
  echo "Created $output_file with numbers divided by $i."
done
	
