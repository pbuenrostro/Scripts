#!/bin/bash



function email() {
        mail -s "Process $1 is not running on $HOSTNAME" $EMAIL < /dev/null
}


date2stamp () {
    date --utc --date "$1" +%s
}

dateDiff (){
    case $1 in
        -s)   sec=1;      shift;;
        -m)   sec=60;     shift;;
        -h)   sec=3600;   shift;;
        -d)   sec=86400;  shift;;
        *)    sec=86400;;
    esac
    dte1=$(date2stamp $1)
    dte2=$(date2stamp $2)
    diffSec=$((dte2-dte1))
    if ((diffSec > 0)); then abs=1; else abs=-500; fi	
    echo $((diffSec/sec*abs))
}
NOW=$(date +"%e-%b-%Y")
#dateDiff $NOW "05-jun-2011"

rm -rf /dev/shm/lic
mkdir -p /dev/shm/lic
/stec/apps/licenses/cadence/lmstat -c /stec/apps/licenses/cadence/license.dat -i | uniq | awk '{print $(1),$(3),$(4)}' | grep -v lmstat | grep -v NOTE | grep -v Flexible | grep -v reads | grep -v Feature | grep -v '_______' > /dev/shm/lic/c
/stec/apps/licenses/cadence/lmstat -c /stec/apps/licenses/synopsys/license.dat -i | uniq | awk '{print $(1),$(3),$(4)}' | grep -v lmstat | grep -v NOTE | grep -v Flexible | grep -v reads | grep -v Feature | grep -v '_______' >> /dev/shm/lic/e
/stec/apps/licenses/cadence/lmstat -c /stec/apps/licenses/novas/license.dat -i | uniq | awk '{print $(1),$(3),$(4)}' | grep -v lmstat | grep -v NOTE | grep -v Flexible | grep -v reads | grep -v Feature | grep -v '_______' >> /dev/shm/lic/g
/stec/apps/licenses/cadence/lmstat -c /stec/apps/licenses/denali/license.dat -i | uniq | awk '{print $(1),$(3),$(4)}' | grep -v lmstat | grep -v NOTE | grep -v Flexible | grep -v reads | grep -v Feature | grep -v '_______' >> /dev/shm/lic/i
/stec/apps/licenses/cadence/lmstat -c /stec/apps/licenses/xilinx/license.dat -i | uniq | awk '{print $(1),$(3),$(4)}' | grep -v lmstat | grep -v NOTE | grep -v Flexible | grep -v reads | grep -v Feature | grep -v '_______' >> /dev/shm/lic/k
/stec/apps/licenses/cadence/lmstat -c /stec/apps/licenses/virage/license.dat -i | uniq | awk '{print $(1),$(3),$(4)}' | grep -v lmstat | grep -v NOTE | grep -v Flexible | grep -v reads | grep -v Feature | grep -v '_______' >> /dev/shm/lic/m
/stec/apps/licenses/arc/lmstat -c /stec/apps/licenses/arc/license.dat -i | uniq | awk '{print $(1),$(3),$(4)}' | grep -v lmstat | grep -v NOTE | grep -v Flexible | grep -v reads | grep -v Feature | grep -v '_______' >> /dev/shm/lic/y
awk 'NF' /dev/shm/lic/c > /dev/shm/lic/d 
awk 'NF' /dev/shm/lic/e > /dev/shm/lic/f 
awk 'NF' /dev/shm/lic/g > /dev/shm/lic/h 
awk 'NF' /dev/shm/lic/i > /dev/shm/lic/j 
awk 'NF' /dev/shm/lic/k > /dev/shm/lic/l 
awk 'NF' /dev/shm/lic/m > /dev/shm/lic/n 
awk 'NF' /dev/shm/lic/y > /dev/shm/lic/z 

#while read line ; do	
#	A=`echo $line | awk '{ print $1 }'`
#	B=`echo $line | awk '{ print $2 }'`
#	C=`echo $line | awk '{ print $3 }'`
#                DIFF=$(dateDiff $NOW $C)
#                if [ $DIFF -le 15  ]; then
#                echo "#licenses:$B License Feature:$A will expire in $DIFF days"
#        fi
#done < /dev/shm/b
while read line ; do
        A=`echo $line | awk '{ print $1 }'`
        B=`echo $line | awk '{ print $2 }'`
        C=`echo $line | awk '{ print $3 }'`
                DIFF=$(dateDiff $NOW $C)
                if [ $DIFF -le 15  ]; then
                echo "#licenses:$B License Feature:$A will expire in $DIFF days" >> /dev/shm/lic/cadence
                
        fi
done < /dev/shm/lic/d

if [ -f /dev/shm/lic/cadence ];
then
SUBJECT="SA Cadence Licenses to expire soon"
RECIPIENT="pbuenrostro@stec-inc.com"
mailx -s "$SUBJECT" -c "$RECIPIENT" ddash@stec-inc.com << MESSAGE
`cat /dev/shm/lic/cadence`
MESSAGE
fi


rm -f /dev/shm/lic/synopsys
while read line ; do
        A=`echo $line | awk '{ print $1 }'`
        B=`echo $line | awk '{ print $2 }'`
        C=`echo $line | awk '{ print $3 }'`
                DIFF=$(dateDiff $NOW $C)
                if [ $DIFF -le 15  ]; then
                echo "#licenses:$B License Feature:$A will expire in $DIFF days" >> /dev/shm/lic/synopsys

        fi
done < /dev/shm/lic/f

if [ -f /dev/shm/lic/synopsys ];
then
SUBJECT="SA Synopsys Licenses to expire soon"
RECIPIENT="pbuenrostro@stec-inc.com"
mailx -s "$SUBJECT" -c "$RECIPIENT" ddash@stec-inc.com << MESSAGE
`cat /dev/shm/lic/synopsys`
MESSAGE
fi

while read line ; do
        A=`echo $line | awk '{ print $1 }'`
        B=`echo $line | awk '{ print $2 }'`
        C=`echo $line | awk '{ print $3 }'`
                DIFF=$(dateDiff $NOW $C)
                if [ $DIFF -le 15  ]; then
                echo "#licenses:$B License Feature:$A will expire in $DIFF days" >> /dev/shm/lic/novas

        fi
done < /dev/shm/lic/h

if [ -f /dev/shm/lic/novas ];
then
SUBJECT="SA Novas Licenses to expire soon"
RECIPIENT="pbuenrostro@stec-inc.com"
mailx -s "$SUBJECT" -c "$RECIPIENT" ddash@stec-inc.com << MESSAGE
`cat /dev/shm/lic/novas`
MESSAGE
fi


while read line ; do
        A=`echo $line | awk '{ print $1 }'`
        B=`echo $line | awk '{ print $2 }'`
        C=`echo $line | awk '{ print $3 }'`
                DIFF=$(dateDiff $NOW $C)
                if [ $DIFF -le 15  ]; then
                echo "#licenses:$B License Feature:$A will expire in $DIFF days" >> /dev/shm/lic/denali

        fi
done < /dev/shm/lic/j

if [ -f /dev/shm/lic/denali ];
then
SUBJECT="SA Denali Licenses to expire soon"
RECIPIENT="pbuenrostro@stec-inc.com"
mailx -s "$SUBJECT" -c "$RECIPIENT" ddash@stec-inc.com << MESSAGE
`cat /dev/shm/lic/denali`
MESSAGE
fi

while read line ; do
        A=`echo $line | awk '{ print $1 }'`
        B=`echo $line | awk '{ print $2 }'`
        C=`echo $line | awk '{ print $3 }'`
                DIFF=$(dateDiff $NOW $C)
                if [ $DIFF -le 15  ]; then
                echo "#licenses:$B License Feature:$A will expire in $DIFF days" >> /dev/shm/lic/xilinx

        fi
done < /dev/shm/lic/l

if [ -f /dev/shm/lic/xilinx ];
then
SUBJECT="SA Xilinx Licenses to expire soon"
RECIPIENT="pbuenrostro@stec-inc.com"
mailx -s "$SUBJECT" -c "$RECIPIENT" ddash@stec-inc.com << MESSAGE
`cat /dev/shm/lic/xilinx`
MESSAGE
fi

while read line ; do
        A=`echo $line | awk '{ print $1 }'`
        B=`echo $line | awk '{ print $2 }'`
        C=`echo $line | awk '{ print $3 }'`
                DIFF=$(dateDiff $NOW $C)
                if [ $DIFF -le 15  ]; then
                echo "#licenses:$B License Feature:$A will expire in $DIFF days" >> /dev/shm/lic/virage

        fi
done < /dev/shm/lic/n

if [ -f /dev/shm/lic/virage ];
then
SUBJECT="SA Virage Licenses to expire soon"
RECIPIENT="pbuenrostro@stec-inc.com"
mailx -s "$SUBJECT" -c "$RECIPIENT" ddash@stec-inc.com << MESSAGE
`cat /dev/shm/lic/virage`
MESSAGE
fi

while read line ; do
        A=`echo $line | awk '{ print $1 }'`
        B=`echo $line | awk '{ print $2 }'`
        C=`echo $line | awk '{ print $3 }'`
                DIFF=$(dateDiff $NOW $C)
                if [ $DIFF -le 15  ]; then
                echo "#licenses:$B License Feature:$A will expire in $DIFF days" >> /dev/shm/lic/arc

        fi
done < /dev/shm/lic/z

if [ -f /dev/shm/lic/arc ];
then
SUBJECT="SA ARC Licenses to expire soon"
RECIPIENT="pbuenrostro@stec-inc.com"
mailx -s "$SUBJECT" pbuenrostro@stec-inc.com << MESSAGE
`cat /dev/shm/lic/arc`
MESSAGE
fi

