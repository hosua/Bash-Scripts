#!/bin/bash
# A basic menu
option=""
options=()
selection=""
while [[ $option != 0 ]]; do
	for i in {1..9}; do
		echo "$i) Option $i"
		options+=("Option $i") # Note: These parenthesis are important
	done
	echo "0) Quit"
	read -p "Select option: " option
	opt="${options[$option-1]}"
	echo "Selected $opt"
	sleep 2
done
