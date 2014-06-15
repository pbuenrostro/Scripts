#!/bin/bash  -x 
HOSTNAME=`hostname`
EMAIL="pbuenrostro"

#Email Function
function email() {
mailx -s "Process from $USER2 on $HOSTNAME" -c paul.buenrostro@hgst.com -c steve.klein@hgst.com "$USER" << MESSAGE
###################################################################
  PLEASE DO NOT REPLY TO THIS AUTO-GENERATED MESSAGE.  THANK YOU!
###################################################################

This process has been running for more than 24HR on server sakpfw:

$PROCESS

Please kill this job if you are no longer using it
Thanks!
Paul Buenrostro

MESSAGE

}

#Check function
function check() {
               PS="archsim"		
	       for a in ${PS}; do {
               MINUTES=$(ps eaxo bsdtime,comm,user | grep $a | cut -c 1-3)
	       for i in ${MINUTES}; do { 
               USER=$(ps eaxo bsdtime,comm,user | grep $i: | awk '{print $3}')
               PROCESS=$(ps -ef | grep $a | grep $USER | awk '{print $2}')
		if [ $i -gt 15  ]; then
                       renice 1 -p $PROCESS 
                        fi

#echo "$i"
#echo "$USER"
#echo "$PROCESS"
}; done;
}; done;
		
}

check 

