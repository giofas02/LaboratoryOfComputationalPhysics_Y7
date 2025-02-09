#!/bin/bash
cd Desktop

# Download the file if not yet there
file_name="data.csv"
# If the file not yet there, download it
# if [ ! -f "$file_name" ]; then
	# curl -L -O path
# fi

# Clean data.csv
grep -v "^#" "$file_name"| sed 's/,//g' > data.txt
echo "Created a cleaned file named data.txt"

# How many even numbers are there?
file_name="data.txt"
en=$(grep -o "[0-9]*" "$file_name" | grep -c "[02468]$")
echo "In $file_name there are $en even numbers"

# Distinguish the entries on the basis of given threshold and count how many belong to each group
THRESHOLD=$(echo "scale=3; 100*sqrt(3)/2" | bc -l)
cg=0
cl=0
while IFS=" " read -r x y z _; do
	DISTANCE=$(echo "scale=3; sqrt(($x)^2 + ($y)^2 + ($z)^2)" |bc -l)
	if [ $(echo "$DISTANCE < $THRESHOLD" | bc -l) -eq 1 ]; then
		((cl++))
	else
		((cg++))
	fi
	done < "$file_name"
echo "There are $cl values below $THRESHOLD and $cg that are greater or equal to it"

# Make 'n' copies of data.txt (with 'n' input parameter of the script) where the i-th copy has all the numbers divided by i (with 'i<=1<=n')
echo "How many copies do you want me to make?"
read n
for (( i=1; i<=$n; i++ )); do
	> copy_${i}.txt
	while read -r line; do
		for word in $line; do
			echo "scale=3; $word / $i" | bc -l >> copy_${i}.txt
		done 
	done < $file_name
done
echo "Made copies. End of execution."

	
