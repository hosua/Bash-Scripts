#!/bin/bash
# A basic script that uses dd to burn an ISO to a drive
# Please use with caution.
echo "Note: This Script will burn an ISO to a drive using dd. Please make sure that it's installed."
echo "This is dangerous if you do not know what you are doing. You have been warned."
sudo fdisk -l | grep "Disk" 
read -p "Which drive do you wish to burn the ISO on? " drive
echo "Selected drive: $drive"
i=0
files=()
for file in *; do
	if [[ $file == *".iso"* ]]; then
		let "i++" # Must use let when working with numeric variables
		echo "$i) $file" # List out all the files for the user to select
		files+=("$file") # Append to a list
	fi
done
read -p "Which ISO do you wish to use? " selection
isofile="${files[$selection-1]}"
echo "Selected ISO: $isofile"
read -p "Are you sure you want to burn '$isofile' to '$drive'? [Y/n] " yesno

if [[ $yesno == Y || $yesno == y || $yesno == "" ]]; then
	echo "Burning $isofile to drive: $drive"
	sudo dd if=$isofile of=$drive status=progress
fi
echo "'$isofile' was successfully burned to '$drive'."


