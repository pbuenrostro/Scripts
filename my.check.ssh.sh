#!/bin/bash
SERVERS="mymatrix01 mymatrix02 mymatrix03 mymatrix04 mymatrix07 mymatrix08 mysge01 mysge02"

COUNT=4

for host in $SERVERS
do
  count=$(ping -c $COUNT $host | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
  if [ $count -eq 0 ]; then
    echo "Host : $host is down (ping failed) couldn't check for SSH service" | mail -s "$host is down" pbuenrostro@stec-inc.com
    else 
         nc -z -w 12 $host 22 || echo "$host SSH service appears to not be working, please check." | mail -s "$host SSH not running..." pbuenrostro@stec-inc.com

  fi
done


