#!/bin/bash
SERVERS="sdmatrix01 sdmatrix02 sdmatrix03 sdlogin01 sdmatrix04 sdmatrix05 sdmatrix06 sdmatrix07 sdmatrix08 sdlnx1 sdlnx2 sdlnx3 sdlnx4 sdlnx5 sdlnx6 sdlnx7 sdlnx8"

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


