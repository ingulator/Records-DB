#!/bin/bash


function print_menu(){

     options=("Add" "Delete" "Search" "UpdateName" "UpdateAmount" "PrintAmount" "PrintAll" "Quit") 
     PS3="select option: " 
while true
 do
    select option in "${options[@]}" 
    do
    local result=0
    case $option in
        
            Add)
            echo "Add records"
            result=$(addRecord)
            logToFile "Add" $result
            ;;
         
            Delete)
            echo "Delete records" 
            result=$(deleteVinyl)
            logToFile "Delete" $result
            ;;   
        
            Search)
            echo "Search"
            #findRecord
            result=$(findRecord)
            #logToFile $result
            ;;
        
            UpdateName)
            echo "Update record names"
            UpdateName
            #result1=$(UpdateName)
            #logToFile $result
            ;;

            UpdateAmount)
            echo "Update record amounts"
            result=$(updateAmount)
            logToFile "UpdateAmount" $result
            ;;   
        
            PrintAmount)
            echo "Print record amounts"
            if printTotal;
            then logToFile "PrintAmount" "Success"
            fi
            logToFile $result
            ;;
        
            PrintAll)
            echo "Print all records"
            if printSorted;
            then logToFile "PrintAll" "Success"  
            fi
            ;;  

            Quit)
            echo
            echo "Exiting program"
            exit
            ;; 
         *)
            echo "Invalid choice. Please select a valid option."
            ;;
    esac
    done

done

}







