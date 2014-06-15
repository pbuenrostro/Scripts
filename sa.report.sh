#!/bin/bash -x
#2/2/11 - Paul Buenrostro
#*************************************************************************************************************************************
#Script uses ssh to get the info from $SAHOSTS, ssh trust should be already operational between $SAHOSTS and the one it runs the script
#Script also depends on the linux utility called vnstat, it should be installed and running on $SAHOSTS already.
#************************************************************************************************************************************
#Script will login in to $SAHOSTS and get today's vnstat average for Network, than memory total,used,free and Swap total,used and free
#Than it will send the report to $RECIPIENT
#

SAHOSTS="samatrix05 samatrix06 samatrix07 samatrix08 sasge01 sasge02 sasge03 sasge04 sasge05 sasge06 sagen4fw sazeusfw"
#Define Recipient
RECIPIENT="pbuenrostro@stec-inc.com"
rm -f /tmp/testingsa
rm -f /tmp/memmsasa

for S in $SAHOSTS
do
V=$(ssh $S vnstat | grep today | awk '{print $(11)$(12)}') 
ssh $S free -g > /tmp/memmsa
Z=$(cat /tmp/memmsa | grep -i mem | awk '{print $(2)}')
A=$(cat /tmp/memmsa | grep + | awk '{print $(3)}')
B=$(cat /tmp/memmsa | grep + | awk '{print $(4)}')
C=$(cat /tmp/memmsa | grep Swap | awk '{print $(2)}' )
D=$(cat /tmp/memmsa | grep Swap | awk '{print $(3)}' )
E=$(cat /tmp/memmsa | grep Swap | awk '{print $(4)}' )


MESSAGE=" 
$S:\n

Today's Network Average Usage:\n
$V\n
Total Memory: $Z GB\n
Memory Used: $A GB\n
Memory Available: $B GB\n
Total Swap: $C GB\n
Swap Used: $D GB\n
Swap Available: $E GB\n\n"
echo -e $MESSAGE >> /tmp/testingsa
done

cat /tmp/testingsa | mail -s "Network and Swap Usage report for Santa Ana" $RECIPIENT
rm -f /tmp/testingsa
rm -f /tmp/memmsasa

exit 0




