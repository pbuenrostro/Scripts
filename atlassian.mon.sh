#!/bin/bash
mail_alert ()
  {
mailx -s "$SUBJECT" paul.buenrostro@hgst.com << MESSAGE
MESSAGE
  }
A=$(curl -s --head  --request GET http://saconfluence01:8090/dashboard.action | grep "200 OK" | awk '{print $(2)}') 
B=$(curl -s --head  --request GET http://jira61:8080/secure/Dashboard.jspa | grep "200 OK" | awk '{print $(2)}') 
C=$(curl -s --head  --request GET http://jira61:8060 | grep "200 OK" | awk '{print $(2)}') 
D=$(curl -s --head  --request GET http://jira/secure/Dashboard.jspa | grep "200 OK" | awk '{print $(2)}') 
#if  [ "$C" == "200" ] && [ "$A" == "200" ] && [ "$B" == "200" ] && [ "$D" == "200" ]; then
#SUBJECT="All Atlassian Apps are up and running!"
#mail_alert
#else 
#SUBJECT="Some Atlassian apps are down!"
#mail_alert
#fi;

if  ! [ "$A" == "200" ]
then
SUBJECT="Confluence is not responding!"
mail_alert
fi;

if  ! [ "$B" == "200" ]  
then
SUBJECT="Jira is not responding!"
mail_alert
fi;

if  ! [ "$C" == "200" ] 
then
SUBJECT="Crucible/Fisheye is not responding!"
mail_alert
fi;

if ! [ "$D" == "200" ] 
then
SUBJECT="Legacy Jira is not responding!"
mail_alert
fi;
