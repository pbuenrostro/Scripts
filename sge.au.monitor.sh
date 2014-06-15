#!/bin/bash -x
#Script to monitor SGE Hosts

#Get the Hostname
HOSTNAME=$(/bin/hostname | /usr/bin/tr '[a-z]' '[A-Z]')
#Define Recipient
RECIPIENT="pbuenrostro@stec-inc.com"
source /stec/apps/sge/*/gs.sh
AU=$(qstat -f | grep -i au )
if qstat -f | grep -i au 
then
echo $AU | mail -s "SA SGE Hosts in AU Mode" $RECIPIENT
else 
exit 0
fi
