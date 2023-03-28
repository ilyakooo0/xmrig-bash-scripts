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
echo "[Unit]" | sudo tee /etc/systemd/system/xmrig.service
echo "Description=XMRIG service" | sudo tee -a /etc/systemd/system/xmrig.service
echo "After=network.target" | sudo tee -a /etc/systemd/system/xmrig.service
echo "StartLimitIntervalSec=0" | sudo tee -a /etc/systemd/system/xmrig.service
echo "[Service]" | sudo tee -a /etc/systemd/system/xmrig.service
echo "Type=simple" | sudo tee -a /etc/systemd/system/xmrig.service
echo "Restart=always" | sudo tee -a /etc/systemd/system/xmrig.service
echo "RestartSec=3" | sudo tee -a /etc/systemd/system/xmrig.service
echo "User=root" | sudo tee -a /etc/systemd/system/xmrig.service
echo "ExecStart=$(pwd)/$_XMRIG_BUILD_LOCATION/xmrig --config=$_XMRIG_CONFIG_LOCATION" | sudo tee -a /etc/systemd/system/xmrig.service
echo "" | sudo tee -a /etc/systemd/system/xmrig.service
echo "[Install]" | sudo tee -a /etc/systemd/system/xmrig.service
echo "WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/xmrig.service

echo "STARTING XMRIG/SERVICES"

sudo service logrotate start
sudo service ntp start
sudo service xmrig start

echo "STARTING XMRIG/SERVICES @ BOOT"

sudo systemctl enable logrotate
sudo systemctl enable ntp
sudo systemctl enable xmrig

echo "${_CYAN}MINING RUNNING${_RESET}"
echo "${_YELLOW}  The process is running in a screen session."
echo "${_YELLOW}  The screen session is named:${_RESET} $_XMRIG_SCREEN"
echo "${_YELLOW}  Command to view process:${_RESET} screen -r $_XMRIG_SCREEN"
echo "${_MAGENTA} ENJOY!!!${_RESET}"

