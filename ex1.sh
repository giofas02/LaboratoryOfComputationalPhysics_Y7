#!/bin/bash

# Make a new directory called students in your home
students_path="$HOME/Desktop/students"
url_path="https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7&e=1"
file_name="LCP_22-23_students.csv"
file_path="$students_path/$filename"

mkdir -p "$students_path"
echo "Created students directory if it wasn't already there"

cd $students_path
# Download the file if not present already
if [ ! -f $file_name ]; then 
	curl -L -O $url_path
fi
echo "Downloaded the students list as $file_name in students directory"

# Make two new file 
grep "PoD" "$file_name" > "PoD_students.csv"
grep "Physics" "$file_name" > "Physics_students.csv"
echo "Made two distinct lists for PoD and Physics students"

# For each letter of the alphabet, count the number of students whose surname starts with that letter
for letter in {A..Z}; do
	count=$(grep -i "^$letter" "$file_name" | wc -l)
	echo "$letter : $count" >> "counts.txt"
	echo "There are $count students whose surname starts by $letter"
	done

# Find out which is the letter with most counts
most_comm=$(sort -t : -k 2 -n "counts.txt" | tail -n 1)
echo "The letter with most counts is $most_comm"

# Assume an obvious numbering of the students in the file and group them modulo 18
for (( i=0; i<18; i++ )); do
	> group_${i}.txt
	line_n=1
	while read -r line; do
		group_n=$(( $line_n % 18 ))
		echo "$line" >> group_${group_n}.txt
		((line_n++))
	done < $file_name
done
echo "Created files modulo 18"
echo "End of execution"  
