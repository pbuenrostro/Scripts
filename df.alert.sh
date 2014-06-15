#!/bin/bash -x
# User modifiable variables:
RECIPIENT="pbuenrostro@stec-inc.com"
FILESYSTEMS="/stec/proj/asic/iguana"
THRESHOLD="90%"

# If you want to add the hostname to the subject line, uncomment the line and add to SUBJECT variable.
#HOSTNAME=$(/bin/hostname | /usr/bin/tr '[a-z]' '[A-Z]')
for FS in $FILESYSTEMS
do
  UTILIZED=$(/bin/df -k $FS | /usr/bin/tail -1 | /usr/bin/awk '{print $(NF-1)}')

# Email Function:
  mail_alert ()
  {

SUBJECT="Filesystem $FS is $UTILIZED full!"
FIND=$(find $FS -size +10000k -type f | xargs ls -s | sort -rn | awk '{size=$1/1024; printf("%dMb %s\n", size,$2);}' | head | grep -v 0Mb)
mailx -s "$SUBJECT" -c kkhagani@stec-inc.com "$RECIPIENT" << MESSAGE
###################################################################
  PLEASE DO NOT REPLY TO THIS AUTO-GENERATED MESSAGE.  THANK YOU!
###################################################################

Please note that $FS is $UTILIZED full and that
it is vital that we bring disk utilization back down.
We really appreciate your help in cleaning up!

Thanks!
MIS TEAM

Descending List of largest files on the file system:
$FIND
MESSAGE
  }

# Compare the utilized value against the threshold:
  if [[ "$UTILIZED" > "$THRESHOLD" ]]; then
        mail_alert
  fi


done

exit 0


