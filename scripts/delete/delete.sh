#!/bin/bash
function deleteVinyl()
{

#Checks if the vinyl that we are trying to delete exists in our 
#database or not 
local albumName1=$(findRecord)
local formattedOutput="`cut -d "," -f2 <<< "$albumName1"`"
local formattedAlbumName="`cut -d "," -f1 <<< "$albumName1"`"	

#If album does not exist, exit
if [[ $albumName1 == " No results found" ]]
then
    echo $albumName1
    echo "Returning to Main Menu."
    return 1
fi

#Returns the current amount of the album
local albumAmount="`echo $albumName1 | awk '{print $(NF)}'`"

#Checks if current amount equals to 1. If its equal to one then we have to delete the row
if [[ $currentAmount -eq 1 ]]
then
    #sed -i "s/oldstr/newstr/g"
    sed -i -e "/$albumName1/d" $DBFilePath$DBFileName
    echo "Record deleted"
    return 1
else
    #Otherwise we call the update amount function with the album name that we want to update,
    #the album amount to be updated 
    #and the -d flag so that the updateAmount function does the relevant code
    #for the delete function 
    updateAmount "-d" "$albumName1" "$albumAmount"
    echo "Delete successful"
    return 1
fi
}
