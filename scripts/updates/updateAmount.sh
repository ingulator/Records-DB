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
    #albumName could either return the album name if found, or it could return 
    #$albumName, No results were found where $albumName is the album the user
    #Is looking for but it was not found in the database.
    #formattedOutput should return " No results were found"
    #And formattedAlbumName returns the album name that was searched for but not found
    local formattedOutput="`cut -d "," -f2 <<< "$albumName"`"
    local formattedAlbumName="`cut -d "," -f1 <<< "$albumName"`"	

    if [[ $formattedOutput == ' No results were found' ]]
    then
        #This is a flag that was passed externally to the main function.
        #This flag lets the program know that the main function was called from the add function, 
        #Thus displaying the relevant messages, checks and asks for relevant inputs from the user
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
	    #Initializing variables
        #stockUp is used for when the user wants to add a record, but the record already exists
        #So stockUp is summed up with the current amount that is in stock and then updates the amount
        #in the database
        stockUp=1
	    
        #amount is the current amount that currenlty exists in stock
        amount=1
	    
        #addFlag is turned to 1 after checking if the function was called with the add function
        addFlag=0

	    if [[ $1 == "-add" ]]
	    then
		    read -p "Album already exists. Please enter the amount that you would like to add to stock: " stockUp
            addFlag=1
	    else
                #The new amount, checks whether amount is valid (greater than 1)
       		     read -p "Please enter new amount: " amount
	    fi

        #Validates the amount the user wishes to update the amount with
       	if [[ $amount -lt 1 || $stockUp -lt 1 ]]
        then
            echo "Invalid amount, amount cannot be less than 1"
            logToFile "Update amount failed, due to invalid input: less than 1."
            exit
        fi
        
        #Returns only the Album name, removing the amount from the row
        local albumNametemp="`printf '%s\n' "${albumName//[[:digit:]]/}" | sed 's/ *$//g'`"
        local albumAmount1="`echo $albumName | awk '{print $(NF)}'`"
        #rev | cut -d ' ' -f 1 | rev`"
         #awk '{print $(NF)}'`"
         
        #Reconstructs the album name and album amount so that it has the same format
        #as the csv file
        local temp="$albumNametemp,$albumAmount1"

	    #Returns the number of row in which the record the user picked is located
	    local rowNumForRecord="`awk -v string="$temp" '$0 == string {print NR}' $DBFilePath$DBFileName`"
      	
        #Checks if the main function was called from the add funciton with the add flag passed
        #As an external argument to the main function
       	if [[ $addFlag -eq 1 ]]
	    then
            #Calculates and sums up between the existing amount and the amount the user
            #wants to add to stock
		    local addAmountToExisting=$(( $albumAmount1+$stockUp ))
		    sed -i -e "${rowNumForRecord}s/,.*/,$addAmountToExisting/" $DBFilePath$DBFileName
	    else
        #This sed command goes through to DB file to the respective row number that was passed to it, and updates the amount of album in said row
 	    sed -i -e "${rowNumForRecord}s/,.*/,$amount/" $DBFilePath$DBFileName
        fi
    fi
fi

}
