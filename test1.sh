#!/bin/bash -x



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
    if ((diffSec < 0)); then abs=-1; else abs=1; fi
    echo $((diffSec/sec*abs))
}
NOW=$(date +"%e-%b-%Y")
#dateDiff $NOW "05-jun-2011"



OUT=$(/stec/apps/licenses/cadence/lmstat -c /stec/apps/licenses/cadence/license.dat -i | uniq | awk '{print $(1),$(3),$(4)}' | grep -v lmstat | grep -v NOTE | grep -v Flexible | grep -v reads | grep -v Feature | grep -v '_______')
YEAR=$(/stec/apps/licenses/cadence/lmstat -c /stec/apps/licenses/cadence/license.dat -i | uniq | awk '{print $(4)}' | grep -v does | grep -v status | grep -v recommend | grep -v licenses | grep -v the | grep -v '(c)' | grep -v '_')

function check() {
                DIFF=$(dateDiff $NOW $3)
                if [ $DIFF -le 37000  ]; then
                echo "#licenses:$2 License Feature:$1 will expire in $DIFF days"
        fi
}

check $OUT
