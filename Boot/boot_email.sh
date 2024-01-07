#!/bin/bash
# Sends email via msmtp config on boot
HOME=/home/pi

sleep 60  # Wait for 60 seconds

{
        echo "Starting email send for reboot..."
        echo -e "Subject: RetroPie system rebooted\r\n\r\nThe RetroPie System rebooted  on $(date)" | msmtp --file=/home/pi/.msmtprc -a gmail  username@gmail.com
        echo "Email send attempt completed."
} >> /home/pi/boot_email_log.txt 2>&1
