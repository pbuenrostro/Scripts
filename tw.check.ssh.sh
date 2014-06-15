#!/bin/bash
SERVERS="twmatrix02 twmatrix04 twmatrix06 twmatrix07 twmatrix08 twmatrix09 twmatrix10 twmatrix11 twmatrix12 twmatrix13 twmatrix14 twmatrix15 twmatrix16 twlic twsge01 twsge02 twsge03 twlogin01 twlogin02 twlic01"

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


