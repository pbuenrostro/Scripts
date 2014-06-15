#!/bin/bash
#Script will check three license features from Xtensa license server and if all have at least one license available
#it will exit successfully otherwise it will print a message and exit 1
SDK=`/stec/apps/licenses/cadence/lmstat -a -c 7777@salic01 | grep -i XTENSA_SDK | awk '{print $(6)}'`
SDK_USED=`/stec/apps/licenses/cadence/lmstat -a -c 7777@salic01 | grep -i XTENSA_SDK | awk '{print $(11)}'`
let SDK_AVAILABLE=$SDK-$SDK_USED
TURBO=`/stec/apps/licenses/cadence/lmstat -a -c 7777@salic01 | grep -i XT_ISS_TURBO | awk '{print $(6)}'`
TURBO_USED=`/stec/apps/licenses/cadence/lmstat -a -c 7777@salic01 | grep -i XT_ISS_TURBO | awk '{print $(11)}'`
let TURBO_AVAILABLE=$TURBO-$TURBO_USED
XTMP=`/stec/apps/licenses/cadence/lmstat -a -c 7777@salic01 | grep -i XT_ISS_XTMP | awk '{print $(6)}'`
XTMP_USED=`/stec/apps/licenses/cadence/lmstat -a -c 7777@salic01 | grep -i XT_ISS_XTMP | awk '{print $(11)}'`
let XTMP_AVAILABLE=$XTMP-$XTMP_USED
#echo $SDK_AVAILABLE
#echo $TURBO_AVAILABLE
#echo $XTMP_AVAILABLE
if (( "$SDK_AVAILABLE" > 0 )) && (( "$TURBO_AVAILABLE" > 0 )) && (( "$XTMP_AVAILABLE" > 0 )); then 
exit 0
else 
echo "Licenses not available"
exit 1
fi

