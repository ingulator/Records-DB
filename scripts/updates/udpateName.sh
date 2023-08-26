#! /bin/bash
function updateName()
{
    local albumName=$(findRecord)
    local formattedOutput="`cut -d "," -f2 <<< "$albumName"`"
    local formattedAlbumName="`cut -d "," -f1 <<< "$albumName"`"	

    if [[ $formattedOutput == ' No results found' ]]
    then
                echo $albumName
                echo "Returning to Main Menu."
    else
        
        #Reconstructs the album name and album amount so that it has the same format
        #as the csv file
        read -p "Please enter a new name for the album: " newName

        #Returns only the Album name, removing the amount from the row
        local albumNametemp="`printf '%s\n' "${albumName//[[:digit:]]/}" | sed 's/ *$//g'`"
        local albumAmount1="`echo $albumName | awk '{print $(NF)}'`"
        #rev | cut -d ' ' -f 1 | rev`"
        #awk '{print $(NF)}'
        
        local temp="$albumNametemp,$albumAmount1"
        
	    #Returns the number of row in which the record the user picked is located
	    local rowNumForRecord="`awk -v string="$temp" '$0 == string {print NR}' $DBFilePath$DBFileName`"
      	
        #This sed command goes through to DB file to the respective row number that was passed to it, and updates the amount of album in said row
 	    sed -i -e "${rowNumForRecord}s/$albumNametemp/$newName/" $DBFilePath$DBFileName
    fi
}
