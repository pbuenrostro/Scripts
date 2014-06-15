#!/bin/bash -x
#Script to monitor processes
#2/2/11 - Paul Buenrostro

#Add processes as they show with ps command
SERVICE="httpd xinetd crond"
#Get the Hostname
HOSTNAME=$(/bin/hostname | /usr/bin/tr '[a-z]' '[A-Z]')
#Define Recipient
RECIPIENT="pbuenrostro@stec-inc.com"

#Check every $SERVICE and email $RECIPIENT if $SERVICE doesn't show with ps command
for S in $SERVICE
do
 
if ps ax | grep -v grep | grep $S > /dev/null
then
    echo "$S service running, everything is fine"
else
    echo "$S is not running"
    echo "$S is not running!" | mail -s "$S is not running!!! on $HOSTNAME" $RECIPIENT
fi
done
exit 0



