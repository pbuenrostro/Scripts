#!/bin/bash -x

A=$(cat /var/log/maillog | grep -i jira61 | grep -i @stec-inc.com | awk '{ print $6 }')

for S in $A
do
cat /var/log/maillog | grep -i $S | grep -i recipient | grep -i stec-inc.com >> /tmp/c
done





