#!/bin/bash


#Variables
HOSTNAME=`hostname`
EMAIL="pbuenrostro@stec-inc.com"
CADENCE='/stec/apps/licenses/cadence/license.dat'
SYNOPSYS='/stec/apps/licenses/synopsys/license.dat'
DENALI='/stec/apps/licenses/denali/license.dat'
NOVAS='/stec/apps/licenses/novas/license.dat'
ARTERIS='/stec/apps/licenses/arteris/license.dat'
ARC='/stec/apps/licenses/arc/license.dat'
XILINX='/stec/apps/licenses/xilinx/license.dat'



#Email Function
function email() {
M="$@"
next="$@"
while [ -n "${next}" ] ; do
  last=$next
  shift
  next=$1
done

if [ $last -eq 1 ]; then
V="Cadence"
A=$cdsexp
else if [ $last -eq 2 ]; then
V="Synopsys"
A=$synexp
else if [ $last -eq 3 ]; then
V="Denali"
A=$denexp
else if [ $last -eq 4 ]; then
V="Novas"
A=$novasexp
else if [ $last -eq 5 ]; then
V="Arteris"
A=$arterisexp
else if [ $last -eq 6 ]; then
V="Arc"
A=$arcexp
else
V=""

fi
fi
fi
fi
fi
fi
echo "$A" | mail -s "WARNING!! the following $V license features will expire this month" $EMAIL
}

#CURRENT YEAR, MONTH and DAY
cmonth=`date | awk '{print $(2)}' | awk '{print tolower($0)}'`
cyear=`date | awk '{print $(6)}'`
cday=`date | awk '{print $(3)}'`

#CADENCE
cdsmonth=`cat $CADENCE | grep -i cdslmd | awk '{print $(5)}'  | grep -i $cyear | cut -c 4-6 | sort | uniq`
cdsday=`cat $CADENCE | grep -i cdslmd | awk '{print $(5)}'  | grep -i $cyear | grep -i $cmonth | cut -c 1-2 | sort | uniq`
cdsexp=`cat $CADENCE | grep -i cdslmd | grep -i $cyear | awk '{print $(2),$(5)}' | grep -i $cmonth`

#SYNOPSYS
synmonth=`cat $SYNOPSYS | grep -i snpslmd | awk '{print $(5)}'  | grep -i $cyear | cut -c 4-6 | sort | uniq`
synday=`cat $SYNOPSYS | grep -i snpslmd | awk '{print $(5)}'  | grep -i $cyear | grep -i $cmonth | cut -c 1-2 | sort | uniq`
synexp=`cat $SYNOPSYS | grep -i snpslmd | grep -i $cyear | awk '{print $(2),$(5)}' | grep -i $cmonth`

#DENALI
denmonth=`cat $DENALI | grep -i denalid | awk '{print $(5)}'  | grep -i $cyear | cut -c 4-6 | sort | uniq`
denday=`cat $DENALI | grep -i denalid | awk '{print $(5)}'  | grep -i $cyear | grep -i $cmonth | cut -c 1-2 | sort | uniq`
denexp=`cat $DENALI | grep -i denalid | grep -i $cyear | awk '{print $(2),$(5)}' | grep -i $cmonth`

#NOVAS
novasmonth=`cat $NOVAS | grep -i snslmgrd | awk '{print $(5)}'  | grep -i $cyear | cut -c 4-6 | sort | uniq`
novasday=`cat $NOVAS | grep -i snslmgrd | awk '{print $(5)}'  | grep -i $cyear | grep -i $cmonth | cut -c 1-2 | sort | uniq`
novasexp=`cat $NOVAS | grep -i snslmgrd | grep -i $cyear | awk '{print $(2),$(5)}' | grep -i $cmonth`


#ARTERIS
arterismonth=`cat $ARTERIS | grep -i arterisd | awk '{print $(5)}'  | grep -i $cyear | cut -c 4-6 | sort | uniq`
arterisday=`cat $ARTERIS | grep -i arterisd | awk '{print $(5)}'  | grep -i $cyear | grep -i $cmonth | cut -c 1-2 | sort | uniq`
arterisexp=`cat $ARTERIS | grep -i arterisd | grep -i $cyear | awk '{print $(2),$(5)}' | grep -i $cmonth`

#ARCD
arcmonth=`cat $ARC | grep -i arcd | awk '{print $(5)}'  | grep -i $cyear | cut -c 4-6 | sort | uniq`
arcday=`cat $ARC | grep -i arcd | awk '{print $(5)}'  | grep -i $cyear | grep -i $cmonth | cut -c 1-2 | sort | uniq`
arcexp=`cat $ARC | grep -i arcd | grep -i $cyear | awk '{print $(2),$(5)}' | grep -i $cmonth`


function check() {
if [ $1 -eq 1 ]; then
		expired=$cdsexp
		V="1"
		else if 
		[ $1 -eq 2 ]; then
		expired=$synexp
		V="2"
		else if
		[ $1 -eq 3 ]; then
		expired=$denexp
		V="3"
		else if
                [ $1 -eq 4 ]; then
                expired=$novasexp
		V="4"
		else if
                [ $1 -eq 5 ]; then
                expired=$arterisexp
		V="5"
		else if
                [ $1 -eq 6 ]; then
                expired=$arcexp
		V="6"
		fi
		fi
		fi
		fi
		fi
		fi
for month in "$@";
do
 if [ "$month" == "$cmonth"  ]; then
	
       email $expired $V
fi
done
}


check 1 $cdsmonth
check 2 $synmonth
check 3 $denmonth
check 4 $novasmonth
check 5 $arterismonth
check 6 $arcmonth

