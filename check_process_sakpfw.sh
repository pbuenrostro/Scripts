#!/bin/bash   
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
               PS="archsim bsim"		
	       for a in ${PS}; do {
               MINUTES=$(ps eaxo bsdtime,comm,user | grep $a | cut -c 1-4 | grep -v :)
	       for i in ${MINUTES}; do { 
               USER=$(ps eaxo bsdtime,comm,user | grep $i: | awk '{print $3}')
               USER2=$(ps eaxo bsdtime,comm,user | grep $i: | awk '{print $3}')
	       USER3=$(ps eaxo bsdtime,comm,user | grep $i: | awk '{print $3}')
               USER3="$USER3@stec-inc.com"	
               PROCESS=$(ps -ef | grep $a | grep $USER)
		if [ $USER = "mharvill" ]; then
			USER="mike.harvill@hgst.com"
				 elif [ $USER = "jchan" ]; then
                        		USER="jeerun.chan@hgst.com"
						 elif [ $USER = "jmolina" ]; then
                        			USER="john.molina@hgst.com"
							 elif [ $USER = "kpfwsqa" ]; then
                        				USER="mukesh.rajan@hgst.com onur.bulut@hgst.com tom.reed@hgst.com"
								elif [ $USER = "ccheung" ]; then	
                                                        	USER="caesar.cheung@hgst.com"
									elif [ $USER = "yji" ]; then
                                                                USER="yungli.ji@hgst.com"
								elif [ $USER = "treed" ]; then
                                                                USER="tom.reed@hgst.com"
								elif [ $USER = "joberly" ]; then
                                                                USER="john.oberly@hgst.com"
						        	 elif [ $USER = "chowe" ]; then
                                                                USER="collin.howe@hgst.com"
								else
                                                                USER="$USER3"
								

fi

		if [ $i -gt 1440  ]; then
                        email $USER $PROCESS $USER2
                        fi


#echo "$i"
#echo "$USER"
#echo "$PROCESS"
}; done;
}; done;
		
}

check 

