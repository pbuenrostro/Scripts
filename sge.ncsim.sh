#!/bin/bash
source /stec/apps/sge/sge6_2u5/gs.sh
GOON=1
while [ $GOON ]; do
TOTAL=`/stec/apps/licenses/cadence/lmstat -a -c 5280@samatrix02 | grep -i enterprise_sim | awk '{print $(6)}'`
USED=`/stec/apps/licenses/cadence/lmstat -a -c 5280@samatrix02 | grep -i enterprise_sim | awk '{print $(11)}'`
let AVAILABLE=$TOTAL-$USED
#echo $AVAILABLE
qconf -mattr exechost complex_values ncsim=$AVAILABLE global
sleep 5
done
#while read line ; do
#done

