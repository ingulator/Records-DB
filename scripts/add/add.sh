#! /bin/bash


function addRecord()
{
	local recordToAdd=$(findRecord "-add")
	
	local formattedOutput="`cut -d "," -f2 <<< "$recordToAdd"`"
	local formattedAlbumName="`cut -d "," -f1 <<< "$recordToAdd"`"	
	
	if [[ formattedOutput == " No results found" ]]
	then
		echo "Record was not found in stock, adding it to the Database."
		read -p "Please enter the amount of Albums to add" albumAmt

		if [[ $albumAmt -lt 1 ]]
		then 
			echo "Invalid amount of Albums"
			echo "failure"
			exit
		else
			echo "$formattedAlbumName,$albumAmt" >> "$DBFilePath$DBFileName"
			echo "success"
		fi
	else


}

