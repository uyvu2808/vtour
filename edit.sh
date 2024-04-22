#!/bin/bash

FILE_PATH="/var/www/vinapy/license.lic"
export LC_TIME="en_US.UTF-8"
NEW_EXPIRATION_DATE=$(date -d "+10 years" +"%a, %d %b %Y 00:00:01 GMT")
read -p "Enter new MaxDevices value: " max_devices
sed -i "s|<Expiration>.*</Expiration>|<Expiration>${NEW_EXPIRATION_DATE}</Expiration>|" $FILE_PATH
sed -i "s|<Feature name=\"MaxDevices\">1</Feature>|<Feature name=\"MaxDevices\">${max_devices}</Feature>|" $FILE_PATH
sed -i 's|<Feature name="MaxPorts">1</Feature>|<Feature name="MaxPorts">30</Feature>|' $FILE_PATH
LIC_FILE="/var/lib/grub/pkm/dll/lic.sh"
HDD_SERIAL=$(sudo lshw -class disk | grep serial | awk '{print $2}')
CPU_DESCRIPTION=$(lscpu | grep "Model name:" | awk -F ":" '{print $2}' | xargs)
sed -i "s|EXPECTED_HDD_SERIAL=.*|EXPECTED_HDD_SERIAL=\"${HDD_SERIAL}\"|" $LIC_FILE
sed -i "s|EXPECTED_CPU_DESCRIPTION=.*|EXPECTED_CPU_DESCRIPTION=\"${CPU_DESCRIPTION}\"|" $LIC_FILE
echo "lic.sh file has been updated with current HDD serial and CPU description."
DDNS_FILE="/var/lib/grub/pkm/dll/ddns.sh"
read -p "Enter the new subdomain for the DNS record (e.g., 'mynewsubdomain'): " subdomain
sed -i "s|record_name=.*|record_name=${subdomain}.lumicproxy.com|" $DDNS_FILE
echo "ddns.sh file has been updated."
echo "File has been updated."
