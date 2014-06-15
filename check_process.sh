#!/bin/bash
#Script Name Check Processes
#Script will check in the process table for the arguments, if found it will report how many instances, hostname
#and the user that owns them. It not it will email and notify.
#Variables
HOSTNAME=`hostname`
EMAIL="pbuenrostro@stec-inc.com"

#Make sure you get arguments
if [ ! -n "$1" ]
     then
     echo -e "\nUsage: `basename $0` process_name1, process_name2, etc..."
     exit 0
   fi

#Email Function
function email() {
        mail -s "Process $1 is not running on $HOSTNAME" $EMAIL < /dev/null
}

#Check function
function check() {
	for arg in "$@";
	do
        PS=`ps -ef | grep -v grep | grep -v check_process| grep -i $arg | wc -l`
 	USER=`ps -ef | grep -v grep | grep -v check_process| grep -i $arg | awk '{print $(1)}' | sort | uniq`
		if [ $PS -gt 0  ]; then
		echo "$arg is running ok......"
		else
	        	email $arg
	fi
	done
}

#Run check function with users argument(s)
check "$@"

