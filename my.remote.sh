#!/bin/bash
SERVERS=" mysge01 mysge02 mysge03 mysge04 mysge07 mysge08 mylogin01"

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


