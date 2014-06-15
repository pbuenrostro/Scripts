#!/bin/bash -x
#2/2/11 - Paul Buenrostro
#*************************************************************************************************************************************
#Script uses ssh to get the info from $TWHOSTS, ssh trust should be already operational between $TWHOSTS and the one it runs the script
#Script also depends on the linux utility called vnstat, it should be installed and running on $TWHOSTS already.
#************************************************************************************************************************************
#Script will login in to $TWHOSTS and get today's vnstat average for Network, than memory total,used,free and Swap total,used and free
#Than it will send the report to $RECIPIENT
#
rm -f /tmp/testing
rm -f /tmp/memm
TWHOSTS="twmatrix01 twmatrix02 twsge01 twsge02 twsge03 twmatrix04 twmatrix06 twmatrix07 twmatrix08 twmatrix09 twmatrix10 twmatrix11 twmatrix12 twmatrix13 twmatrix14 twmatrix15 twmatrix16"

#Define Recipient
RECIPIENT="pbuenrostro@stec-inc.com"

for S in $TWHOSTS
do
V=$(ssh $S vnstat | grep today | awk '{print $(11)$(12)}') 
ssh $S free -g > /tmp/memm
Z=$(cat /tmp/memm | grep -i mem | awk '{print $(2)}')
A=$(cat /tmp/memm | grep + | awk '{print $(3)}')
B=$(cat /tmp/memm | grep + | awk '{print $(4)}')
C=$(cat /tmp/memm | grep Swap | awk '{print $(2)}' )
D=$(cat /tmp/memm | grep Swap | awk '{print $(3)}' )
E=$(cat /tmp/memm | grep Swap | awk '{print $(4)}' )


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
echo -e $MESSAGE >> /tmp/testing
done

cat /tmp/testing | mail -s "Network and Swap Usage report for Taiwan" $RECIPIENT
rm -f /tmp/testing
rm -f /tmp/memm
exit 0




