#!/bin/bash

# Sends email via msmtp config when EmulationStation stops running
# Runs as a service via emulation-monitor.service

# Define send_email function
send_email() {
    echo "EmulationStation has stopped. Sending email..."
    /usr/bin/msmtp --file=/home/pi/.msmtprc -a gmail username@gmail.com <<EOF
Subject: EmulationStation Stopped on RetroPie
EmulationStation has stopped on $(date)
EOF
}

while true; do
    # Check if EmulationStation is running
    if ps aux | grep -v "monitor_emulationstation.sh" | grep [e]mulationstation > /dev/null; then
        echo "$(date): EmulationStation is running."
        # If running, wait for it to stop
        while ps aux | grep -v "monitor_emulationstation.sh" | grep [e]mulationstation > /dev/null; do
            sleep 60
        done
        # Once it stops, send an email
        send_email
    else
        echo "$(date): EmulationStation not running, checking again in 60 seconds."
        # If not running, wait for a while before checking again
        sleep 60
    fi
done
