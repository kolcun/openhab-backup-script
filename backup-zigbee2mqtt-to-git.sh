#!/bin/bash

currentDate=`date`
commitMessage="Daily Backup: $currentDate"

logger Daily zigbee2mqtt backup: start

backupLocation="/opt/zigbee2mqtt-backup/"

cp /opt/zigbee2mqtt/data/configuration.yaml $backupLocation
cp /opt/zigbee2mqtt/data/coordinator_backup.json $backupLocation
cp /opt/zigbee2mqtt/data/*.js $backupLocation

cd $backupLocation
git add .
git commit -m "$commitMessage"
git push

