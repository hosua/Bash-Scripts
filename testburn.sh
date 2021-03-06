#!/bin/bash
# A basic script that uses dd to burn an ISO to a drive
# Please use with caution.
echo "Note: This Script will burn an ISO to a drive using dd. Please make sure that it's installed."
echo "This is dangerous if you do not know what you are doing. You have been warned."
# If we don't use -E (Extended grep), we will have to add backslash to escape characters.
# sudo fdisk -l | grep "\(/dev/sd[a-z]:\|/dev/loop[0-9]\)"
# With extended grep, we can ignore this behavior.
sudo fdisk -l | grep -E "(/dev/sd[a-z]:|/dev/nvme[0-26]n1:|/dev/fd[0-1]:|/dev/sd[a-z]:|/dev/scd[0-20]:|/dev/hd[a-z])" | cut -c 6- 
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
echo "Note: You will need to put this script in the same directory as your ISO files in order for the script to detect them."
read -p "Which ISO do you wish to use? (Enter the number to select an option)" selection
isofile="${files[$selection-1]}"
echo "Selected ISO: $isofile"
read -p "Are you sure you want to burn '$isofile' to '$drive'? All files on the selected drive will be overwritten! [Y/n] " yesno

if [[ $yesno == Y || $yesno == y || $yesno == "" ]]; then
	echo "Burning $isofile to drive: $drive"
	#sudo dd if=$isofile of=$drive status=progress
	echo "'$isofile' was successfully burned to '$drive'."
else
	echo "User did not select yes, cancelling the task..."
fi


