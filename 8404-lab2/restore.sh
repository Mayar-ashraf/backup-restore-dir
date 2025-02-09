#!/bin/bash

if [ $# -ne 2 ]
then 
        echo "$0 needs 2 arguments!"
        echo "Required Command:  ./restore.sh <dir> <backupdir>"
        exit 1
fi
 

backup_timestamp=$(ls "$2" | sort | tail -n 1)
echo "Current state timestamp is: $backup_timestamp"

while :
do
echo "Choose an option from the menu below:"
echo "1. Move Backward."
echo "2. Move Forward."
echo "3. Exit."
read input;

case $input in
    1)  buffer=$(ls $2 | sort | grep -B1 $backup_timestamp | head -n 1)

	if [[ "$backup_timestamp" = "$buffer" ]];  
	then 
		echo "No older backup available to restore."
		sleep 2;
	else
		backup_timestamp="$buffer"
		rm -r $1/*
		cp -r $2/$backup_timestamp/* $1
		echo "Restored to a previous version: $backup_timestamp"
		sleep 2;
	fi 
	;;
    2)  buffer=$(ls $2 | sort | grep -A1 $backup_timestamp | tail -n 1)
	if [[ "$backup_timestamp" = "$buffer" ]];  
        then 
                echo "No newer backup backup available to restore."
		sleep 2;
        else
                backup_timestamp="$buffer"
                rm -r $1/*
                cp -r $2/$backup_timestamp/* $1
                echo "Restored to a next version: $backup_timestamp"
        	sleep 2; 
	fi 
        ;;

    3)  echo "Exiting .."
	exit 0;;
    *)  echo "Please enter an appropriate option."
	sleep 1;;
esac
done
