#!/bin/bash
#Script Name Check Processes
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
        USER=`ps -ef | grep -v qsub | grep -v grep | grep -v qrsh | grep -v check.proc.salogin | grep -i $arg | awk '{print $(1)}' | sort | uniq`
	  for usa in $USER;
        do
	PROCESS=`ps -ef | grep -v grep | grep -v qsub | grep -v qrsh | grep -v check.proc.salogin | grep -i $arg | grep -i $usa`
	if [ "$usa" = "1110" ]; then
       		 USER="bpetreaca"
        elif [ "$usa" = "2031" ]; then
        	USER="charleswu"
        fi
		if [ $arg = "check_version" ]; then
       	                         arg="ncsim"
       		                 fi

	mail -s "You have a $arg process running on $HOSTNAME" $usa@stec-inc.com << MESSAGE
###################################################################
  PLEASE DO NOT REPLY TO THIS AUTO-GENERATED MESSAGE.  THANK YOU!
###################################################################

Process:
$PROCESS

This process might be consuming too many resources(cpu, memory) on $HOSTNAME.
Please stop it immediately and resubmit using SGE if necessary.
Process could be terminated any time if it affects login host performance.
Thanks!

MIS
MESSAGE


done

}

#Check function
function check() {
	for arg in "$@";
	do
        PS=`ps -ef | grep -v grep | grep -v qrsh | grep -v qsub | grep -v check.proc.salogin| grep -i $arg | wc -l`
		if [ $PS -gt 0  ]; then
			if [ $arg = "check_version" ]; then
		email $arg
		fi
	fi
	done
}

#Run check function with users argument(s)
check "$@"
