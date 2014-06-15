#!/bin/bash
SERVERS="samatrix05 samatrix06 samatrix07 samatrix08 sasge01 sasge02 sasge03 sasge04 sasge05 sasge06 sasmb sads01 salogin01 salogin02"

COUNT=4

for host in $SERVERS
do
  count=$(ping -c $COUNT $host | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
  if [ $count -eq 0 ]; then
    echo "Host : $host is down (ping failed) couldn't check for SSH service" | mail -s "$host is down" pbuenrostro@stec-inc.com
    else 
         nc -z -w 8 $host 22 || echo "$host SSH service appears to not be working, please check." | mail -s "$host SSH not running..." pbuenrostro@stec-inc.com

  fi
done


