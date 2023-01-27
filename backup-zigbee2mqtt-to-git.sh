#!/bin/bash

currentDate=`date`
commitMessage="Daily Backup: $currentDate"

logger Daily zigbee2mqtt backup: start

function push {
    curl -s -F "token=a87h419p6yvbak54261w8tp1aixjfr" \
    -F "user=uskVCNTGyLQGVoETqHiZaBhG75SU2L" \
    -F "title=Openhab3 Backup Cron Script" \
    -F "message=$1" https://api.pushover.net/1/messages.json
}

backupLocation="/opt/zigbee2mqtt-backup/"

cp /opt/zigbee2mqtt/data/configuration.yaml $backupLocation
cp /opt/zigbee2mqtt/data/coordinator_backup.json $backupLocation
cp /opt/zigbee2mqtt/data/*.js $backupLocation

cd $backupLocation
git add .
git commit -m "$commitMessage"
if ! git push
then
        push "zigbee github push failed"
fi


