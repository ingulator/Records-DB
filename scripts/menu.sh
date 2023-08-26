#!/bin/bash


function print_menu(){

     options=("Add" "Delete" "Search" "UpdateName" "UpdateAmount" "PrintAmount" "PrintAll" "Quit") 
     PS3="select option: " 
while true
 do
    select option in "${options[@]}" 
    do
    case $option in
        
            Add)
            echo "Add records"
            result=$(addRecord)
            logToFile $result
            exit
            ;;
         
            Delete)
            echo "Delete records" 
            result =$(deleteVinyl)
            logToFile $result
            exit
            ;;   
        
            Search)
            echo "Search"
            result = findRecord
            logToFile $result
            exit
            ;;
        
            UpdateName)
            echo "Update record names"
            ;;

            UpdateAmount)
            echo "Update record amounts"
            result=$(updateAmount)
            logToFile $result
            exit
            ;;   
        
            PrintAmount)
            echo "Print record amounts"
            printTotal
            ;;
        
            PrintAll)
            echo "Print all records"
            printSorted
            exit
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







