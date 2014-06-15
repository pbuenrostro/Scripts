#!/bin/bash
SERVERS="r27 r30 r31 r32 r33 r34 r35 r36 r37"

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


