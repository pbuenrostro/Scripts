#!/bin/bash -x
RECIPIENT="paul.buenrostro@hgst.com"
THRESHOLD="12000"

USED=$(free -m | awk 'FNR == 3 {print}' | awk '{ print $3 }')
AVAILABLE=$(free -m | awk 'FNR == 2 {print}' | awk '{ print $2 }')

# Email Function:
  mail_alert ()
  {

SUBJECT="MEMORY ALERT!!!! on Jira Production System"
mailx -s "$SUBJECT" "$RECIPIENT" << MESSAGE
Memory Used $USED of $AVAILABLE on Jira Production System
MESSAGE
  }

# Compare the utilized value against the threshold:
  if [[ "$USED" -ge "$THRESHOLD" ]]; then
        mail_alert
  fi


exit 0
