#!/bin/bash
SERVERS="salogin01 salogin02 salogin03 salogin04 sasge01 sasge02 sasge03 sasge04 sasge05 sasge06 sasge07 sasge08 sasge09 sasge10 sasge11 sasge12 sasge13 sasge14 sasge15 sasge16 sasge17 sasge18 sasge19"

COUNT=4

for host in $SERVERS
do
  count=$(ping -c $COUNT $host | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
  if [ $count -eq 0 ]; then
    # 100% failed 
    echo "Host : $host is down (ping failed) at $(date)"
    else 
         echo "--------------------------------"
	 echo "* HOST: $host "
	 echo "--------------------------------"
       	ssh $host $1 $2 $3 $4 $5

  fi
done


