#!/bin/bash -x

A=$(cat /tmp/b | grep -i jira61 | grep -i @stec-inc.com | awk '{ print $6 }')

for S in $A
do
cat /tmp/b | grep -i $S | grep -i recipient >> /tmp/c
done





