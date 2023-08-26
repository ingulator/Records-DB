#! /bin/bash
function updateAmount()
{
if [[ $1 == "-d" ]]
then
   #This is the Album name passed as an argument when the user runs the delete function
   local tempAlbumName=$2

   #This line basically removes all but the album name from the string, it removes the amount and whitespaces as well
   local AlbumName="`printf '%s\n' "${tempAlbumName//[[:digit:]]/}" | sed 's/ *$//g'`"
   
   #$3 Is yet another external argument passed to updateAmount() via the delete function, and it has the album amount in it
   local tempAlbumAmount=$3
 
   #This was used to reconstruct the two strings, concat them and add a comma right in between the album name and amount
   #so that the string would match the csv format (ALBUMNAME,ALBUMAMOUNT)
   local tempRecord="$AlbumName,$tempAlbumAmount"
  
   #This is the new amount that is going to be inserted into the csv file
   local amount=$(( $tempAlbumAmount-1 ))
   
   #This awk function runs through the DB file and looks for exact matches, once found, it returns the number of row and stores it into 
   #rowNumForRecord1 local variable
   local rowNumForRecord1="`awk -v string1="$tempRecord" '$0 == string1 {print NR}' $DBFilePath$DBFileName`"
  
   #This sed command goes through to DB file to the respective row number that was passed to it, and updates the amount of album in said row 
   sed -i -e "${rowNumForRecord1}s/,.*/,$amount/" $DBFilePath$DBFileName
else
    local albumName=$(findRecord)
    local formattedOutput="`cut -d "," -f2 <<< "$albumName"`"
    local formattedAlbumName="`cut -d "," -f1 <<< "$albumName"`"	

    if [[ $formattedOutput == ' No results found' ]]
    then
        if [[ $1 == "-add" ]]
        then
            echo "Record was not found in stock, adding it to the Database."
            read -p "Please enter the amount of Album to add" albumAmt
            
            if [[ $albumAmt -lt 1 ]]
            then
                    echo "Invalid amount of Albums to add"
                logToFile "User tried to add invalid amount of albums: Less than 1"
                exit
                else
                echo "$formattedAlbumName,$albumAmt" >> "$DBFilePath$DBFileName"
                logToFile "Added record: $formattedAlbumName (albumAmt)"
            fi
        else
                echo $albumName
                echo "Returning to Main Menu."
        fi

    else
	    stockUp=1
	    amount=1
	    addFlag=0

	    if [[ $1 == "-add" ]]
	    then
		    read -p "Album already exists. Please enter the amount that you would like to add to stock: " stockUp
		    addFlag=1
	    else
        #The new amount, checks whether amount is valid (greater than 1)
       		     read -p "Please enter new amount: " amount
	     fi

       	if [[ $amount -lt 1 || $stockUp -lt 1 ]]
        then
            echo "Invalid amount, amount cannot be less than 1"
            logToFile "Update amount failed, due to invalid input: less than 1."
            exit
        fi

        #Returns only the Album name, removing the amount from the row
        local albumNametemp="`printf '%s\n' "${albumName//[[:digit:]]/}" | sed 's/ *$//g'`"
        local albumAmount1="`echo $albumName | rev | cut -d ' ' -f 1 | rev`"
        local temp="$albumNametemp,$albumAmount1"
        



        #Returns the number of row in which the record the user picked is located
        local rowNumForRecord="`awk -v string="$temp" '$0 == string {print NR}' $DBFilePath$DBFileName`"
            
        if [[ $addFlag -eq 1 ]]
        then
            local addAmountToExisting=$(( $albumAmount1+$stockUp ))
            sed -i -e "${rowNumForRecord}s/,.*/,$addAmountToExisting/" $DBFilePath$DBFileName
        else
            #This sed command goes through to DB file to the respective row number that was passed to it, and updates the amount of album in said row
        sed -i -e "${rowNumForRecord}s/,.*/,$amount/" $DBFilePath$DBFileName
        fi
    fi
fi
}
