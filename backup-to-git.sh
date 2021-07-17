#!/bin/bash

currentDate=`date`
commitMessage="Daily Backup: $currentDate"

logger Daily openhab backup: start

cd /etc/openhab
git add .
git commit -m "$commitMessage"
git push

cd /var/lib/openhab
git add .
git commit -m "$commitMessage"
git push

logger Daily openhab backup: complete
