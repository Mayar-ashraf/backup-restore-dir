#!/bin/bash

if [ $# -ne 4 ]
then 
	echo "$0 needs 4 arguments!"
	echo "Required Command:  ./backupd.sh <dir> <backupdir> <interval-secs> <max-backups>"
	exit 1
fi

ls -lR $1 > directory-info.last
current_date=$(date +%Y-%m-%d-%H-%M-%S)
echo "First Backup done at: ./$2/$current_date "

cp -r $1 $2/$current_date
while :
do
	sleep $3
	ls -lR $1 > directory-info.new
	cmp directory-info.new directory-info.last > /dev/null 
        if [ ! $? -eq 0 ]
        then
		current_date=$(date +%Y-%m-%d-%H-%M-%S)		
        	cp -r $1 $2/$current_date
       		cp directory-info.new directory-info.last
		echo "Backup created at ./$2/$current_date"
		dirnum=$(ls -ld $2/* | wc -l)
		while [ $dirnum -gt $4 ]
                do
                        echo "Number of backup directories exceeded the max-backups."
			echo "Deleting the oldest backup.."
                        rm -r $2/$(ls -t $2 | tail -1)
			dirnum=$(ls -ld $2/* | wc -l)
                done

	fi

done
