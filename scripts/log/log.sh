#!/bin/bash

function logToFile(){
    unset IFS
    #date '+%Y-%m-%d %H:%M:%S' -a echo $1 >> $logFilePath$logFileName
    printf '%s %s\n' "$(date '+%d-%m-%Y %H:%M:%S')" "$1 $2" >> $logFilePath$logFileName
}