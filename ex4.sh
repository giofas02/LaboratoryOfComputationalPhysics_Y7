#!/bin/bash

# Define threshold
THRESHOLD=$(echo "scale=5; 100 * sqrt(3) / 2" | bc -l)

# Initialize counters
group1_count=0
group2_count=0

# Read the file line by line
while read -r line; do
  # Extract X, Y, Z values (assumes space-separated values)
  X=$(echo "$line" | awk '{print $1}')
  Y=$(echo "$line" | awk '{print $2}')
  Z=$(echo "$line" | awk '{print $3}')
  
  # Calculate sqrt(X^2 + Y^2 + Z^2)
  distance=$(echo "scale=5; sqrt($X^2 + $Y^2 + $Z^2)" | bc -l)

  # Compare with the threshold
  if (( $(echo "$distance > $THRESHOLD" | bc -l) )); then
    group2_count=$((group2_count + 1))
  else
    group1_count=$((group1_count + 1))
  fi
done < data.txt

# Print results
echo "Group 1 (<= $THRESHOLD): $group1_count entries"
echo "Group 2 (> $THRESHOLD): $group2_count entries"


