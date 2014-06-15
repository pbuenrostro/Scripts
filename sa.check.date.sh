#!/bin/bash
SERVERS="samatrix05 samatrix06 samatrix07 samatrix08 sasge01 sasge02 sasge03 sasge04 sasge05 sasge06 sasmb sads01 salogin01 salogin01"

COUNT=4

for host in $SERVERS
do
  count=$(ping -c $COUNT $host | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
  if [ $count -eq 0 ]; then
    # 100% failed 
    echo "Host : $host is down (ping failed) at $(date)"
    else 
         echo "--------------------------------" >> /dev/shm/date.tmp
	 echo "* HOST: $host " >> /dev/shm/date.tmp
	 echo "--------------------------------" >> /dev/shm/date.tmp
       	ssh $host date >> /dev/shm/date.tmp

  fi
done
cat /dev/shm/date.tmp | mail -s "SA Date Report" pbuenrostro@stec-inc.com
rm -f /dev/shm/date.tmp


