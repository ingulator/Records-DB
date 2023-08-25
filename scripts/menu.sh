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
            ;;
         
            Delete)
            echo "Delete records" 
            ;;   
        
            Search)
            echo "Search records"
            #findRecords
            ;;
        
            UpdateName)
            echo "Update record names"
            ;;

            UpdateAmount)
            echo "Update record amounts"
            ;;   
        
            PrintAmount)
            echo "Print record amounts"
            ;;
        
            PrintAll)
            echo "Print all records"
            ;;  

            exit)

            ;; 
         *)
            echo "Invalid choice. Please select a valid option."
            ;;
    esac
    done

done

}







