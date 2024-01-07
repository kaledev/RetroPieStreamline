#!/bin/bash

# Searches for new/changed save files only and copies them to a NAS
# Uses private/public key encryption on the NAS via keychain

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOME=/home/pi

echo 'Running Script'

# Capture the start time
START_TIME=$(date +%s)

echo "Script started at: $(date)"

# Use keychain to for private/public key work

[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
/usr/bin/keychain --noask /home/pi/.ssh/id_rsa

source /home/pi/.keychain/$HOSTNAME-sh

# Find save files only and backup to NAS
find RetroPie/roms/ -name "*.srm" -o -name "*.state*" -print0 | rsync -av --protect-args --files-from - --from0 . "usr@192.168.1.50:/mnt/Backup/"

# Capture the end time
END_TIME=$(date +%s)

# Calculate the runtime
RUNTIME=$((END_TIME - START_TIME))

# Append the runtime to the log
echo "Script ended at: $(date)"
echo "Script run time: $RUNTIME seconds"
echo