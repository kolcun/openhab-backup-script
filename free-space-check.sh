#!/bin/sh

push () {
    curl -s -F "token=a87h419p6yvbak54261w8tp1aixjfr" \
    -F "user=uskVCNTGyLQGVoETqHiZaBhG75SU2L" \
    -F "title=Openhab Free Space" \
    -F "message=$1" https://api.pushover.net/1/messages.json
}

freeSpaceOnDisk=`df -kh | grep  '^/dev/root' | awk '{ print $4 }' |  cut -d'G' -f1`
echo "Space on disk: $freeSpaceOnDisk"
if [ $freeSpaceOnDisk -le 40 ]; then
	echo "Less than 40GB free"
	push "WARNING: Free Space less than 40GB - stopping OpenHab"
	systemctl stop openhab
fi
