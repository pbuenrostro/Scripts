#! /bin/bash

if [ $# -lt 2 ]
then
        echo "Usage : $0 vendor action"
        echo "Vendor can be cadence, synopsys, xilinx, arc, denali, novas, arteris"
        echo "Action can be start, stop or status"
        exit
fi

case "$@" in

'cadence start')  echo "Attempting to start Cadence License Server"
    /stec/apps/licenses/cadence/lmgrd -z -c /stec/apps/licenses/cadence/license.dat 
    ;;
'cadence stop')  echo  "Attempting to stop Cadence License Server"
   /stec/apps/licenses/cadence/lmdown -c /stec/apps/licenses/cadence/license.dat
    ;;
'cadence status')  echo  "Getting Cadence License Server Status......"
   /stec/apps/licenses/cadence/lmstat -a -c /stec/apps/licenses/cadence/license.dat
    ;;
*) echo "Usage : $0 vendor action"
        echo "Vendor can be cadence, synopsys, xilinx, arc, denali, novas, arteris"
        echo "Action can be start, stop or status"
        exit
   ;;
esac
