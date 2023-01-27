#!/bin/bash

currentDate=`date`
commitMessage="Daily Backup: $currentDate"

logger Daily openhab backup: start


function push {
    curl -s -F "token=a87h419p6yvbak54261w8tp1aixjfr" \
    -F "user=uskVCNTGyLQGVoETqHiZaBhG75SU2L" \
    -F "title=Openhab3 Backup Cron Script" \
    -F "message=$1" https://api.pushover.net/1/messages.json
}

cd /etc/openhab
git add .
git commit -m "$commitMessage"
if ! git push
then
        push "/etc/openhab github push failed"
fi


cd /var/lib/openhab
git add .
git commit -m "$commitMessage"
if ! git push
then
        push "/var/lib/openhab github push failed"
fi

cd /home/pi/.node-red
git add *.js*
git add .config*.json
git commit -m "$commitMessage"
if ! git push
then
	push "Nodered github push failed"
fi

logger Daily openhab backup: complete
