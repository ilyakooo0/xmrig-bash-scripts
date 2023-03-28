#!/bin/bash

echo "${_GREEN}MINING STARTED${_RESET}"

# When this script is:
# * run by crontab, load the settings
# * run by install, do not load settings

# Reload settings and functions for when running standalone
. functions.sh
. settings.sh

# if ! screen -list | grep -q "$_XMRIG_SCREEN"; then

        # Call functions
	show_settings
	show_mysettings
        # start_xmrig

        # List screen
        # screen -ls
# else

	# List screen
	# screen -ls

# fi
echo "[Unit]" | tee /etc/systemd/system/xmrig.service
echo "Description=XMRIG service" | tee -a /etc/systemd/system/xmrig.service
echo "After=network.target" | tee -a /etc/systemd/system/xmrig.service
echo "StartLimitIntervalSec=0" | tee -a /etc/systemd/system/xmrig.service
echo "[Service]" | tee -a /etc/systemd/system/xmrig.service
echo "Type=simple" | tee -a /etc/systemd/system/xmrig.service
echo "Restart=always" | tee -a /etc/systemd/system/xmrig.service
echo "RestartSec=3" | tee -a /etc/systemd/system/xmrig.service
echo "User=root" | tee -a /etc/systemd/system/xmrig.service
echo "ExecStart=$(pwd)/xmrig --config=$_XMRIG_CONFIG_LOCATION" | tee -a /etc/systemd/system/xmrig.service
echo "" | tee -a /etc/systemd/system/xmrig.service
echo "[Install]" | tee -a /etc/systemd/system/xmrig.service
echo "WantedBy=multi-user.target" | tee -a /etc/systemd/system/xmrig.service

echo "STARTING XMRIG/SERVICES"

service logrotate start
service ntp start
service xmrig start

echo "STARTING XMRIG/SERVICES @ BOOT"

systemctl enable logrotate
systemctl enable ntp
systemctl enable xmrig

echo "${_CYAN}MINING RUNNING${_RESET}"
echo "${_YELLOW}  The process is running in a screen session."
echo "${_YELLOW}  The screen session is named:${_RESET} $_XMRIG_SCREEN"
echo "${_YELLOW}  Command to view process:${_RESET} screen -r $_XMRIG_SCREEN"
echo "${_MAGENTA} ENJOY!!!${_RESET}"

