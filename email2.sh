#!/bin/bash -x

A=$(cat /var/log/maillog | grep -i jira.stec-inc.ad | grep -i @stec-inc.com | awk '{ print $6 }')

for S in $A
do
cat /var/log/maillog | grep -i $S | grep -i recipient >> /tmp/z
done





