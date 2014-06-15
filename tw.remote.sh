#!/bin/bash
SERVERS="twlogin01 twlogin02 twlogin03 twlogin04 twmatrix01 twsge01 twsge02 twsge03 twsge05 twsge06 twsge07 twsge08 twsge09 twsge10 twsge11 twsge12 twsge13 twsge16 twsge18 twsge19"

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


