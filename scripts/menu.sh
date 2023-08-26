#!/bin/bash


function print_menu(){

     options=("Add" "Delete" "Search" "UpdateName" "UpdateAmount" "PrintAmount" "PrintAll" "Quit") 
     PS3="select option from 1 to 8: " 
while true
 do
    select option in "${options[@]}" 
    do
    local result=0
    case $option in
        
            Add)
            echo "Add records"
            result=$(addRecord)
            logToFile "Add" "Success"
            ;;
         
            Delete)
            echo "Delete records" 
            result=$(deleteVinyl)
            logToFile "Delete" "Success"
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
            logToFile "UpdateName" "Success"
            ;;

            UpdateAmount)
            echo "Update record amounts"
            result=$(updateAmount)
            logToFile "UpdateAmount" "Success"
            ;;   
        
            PrintAmount)
            echo "Print record amounts"
            printTotal
            logToFile "PrintAmount" "Success"
            ;;
        
            PrintAll)
            echo "Print all records"
            printSorted;
            logToFile "PrintAll" "Success"  
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







