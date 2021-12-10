#!/bin/bash
# A basic script that uses dd to burn an ISO to a drive
# Please use with caution.
echo "Note: This Script will burn an ISO to a drive using dd."
echo "This is dangerous if you do not know what you are doing."
# Get a list of all the drives
echo
echo "Drives found on your system:"
sudo fdisk -l | grep -E "(nvme[0-26]n[1-26]:|/sd[a-z]:|/fd[0:26]:|/scd[0-26]:)" | cut -d " " -f 2-
echo 
drives=( $(sudo fdisk -l | grep -E "(nvme[0-26]n[1-26]:|/sd[a-z]:|/fd[0:26]:|/scd[0-26]:)" | cut -d " " -f 2 | cut -d : -f 1) )

# Drive select
i=0
for d in "${drives[@]}"; do
	let i++
	echo $i\) $d
done
read -p "Which drive do you wish to burn the ISO on? (Select number)" selection
drive=${drives[selection-1]}
echo "Selected drive: $drive"

# .iso select
i=0
files=()
for file in *; do
	if [[ $file == *".iso"* ]]; then
		let "i++" # Must use let when working with numeric variables
		echo "$i) $file" # List out all the files for the user to select
		files+=("$file") # Append to a list
	fi
done

if [[ ${files[0]} != "" ]]; then 
	read -p "Which ISO do you wish to use? (Enter the number to select an option)" selection
	isofile="${files[$selection-1]}"
	echo "Selected ISO: $isofile"
else
	echo "Could not find any .iso files! Exiting...\n"
	echo "You will need to put this script in the same directory as your ISO files in order for the script to detect them."
	exit
fi

read -p "Are you sure you want to burn '$isofile' to '$drive'? All files on the selected drive WILL BE DELTED! [Y/n] " yesno

if [[ $yesno == Y || $yesno == y || $yesno == "" ]]; then
	echo "Burning $isofile to drive: $drive"
	sudo dd if=$isofile of=$drive status=progress
	echo "'$isofile' was successfully burned to '$drive'."
else
	echo "User did not select yes, cancelling the task..."
fi


