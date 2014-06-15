#!/bin/bash 

time=60
do_echo=1
if [ $# -ge 1 ]; then
   time=$1
fi
if [ $# -ge 2 ]; then
   do_echo=$2
fi

if [ $do_echo != '0' ]; then
   /bin/echo Here I am. Sleeping now at: `date`
fi

sleep $time

if [ $do_echo != '0' ]; then
   echo Now it is: `date`
fi
