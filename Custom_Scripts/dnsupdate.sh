#!/bin/sh

# Azure - Register Linux VM against DC
# By Jay Klesitz
# Run script on VM: 
# chmod 755 /etc/dhcp/dnsupdate.sh ; /etc/dhcp/dnsupdate.sh ; chmod 755 /etc/rc.d/rc.local; echo "/etc/dhcp/dnsupdate.sh" >> /etc/rc.d/rc.local ; reboot


DCSERVER="server poc-eus-dc1.iglooaz.local"
ZONE="zone iglooaz.local"
ADDR=`/sbin/ifconfig eth0 | grep 'inet ' | awk '{print $2}' | sed -e s/.*://`
HOST=`hostname`
DOMAIN=".iglooaz.local."
RESOLVEDOMAIN="iglooaz.local"


echo $DCSERVER > /etc/dhcp/dnsupdate.txt
echo $ZONE >> /etc/dhcp/dnsupdate.txt
echo "update delete $HOST$DOMAIN A" >> /etc/dhcp/dnsupdate.txt
echo "update add $HOST$DOMAIN 86400 A $ADDR" >> /etc/dhcp/dnsupdate.txt
echo "show" >> /etc/dhcp/dnsupdate.txt
echo "send" >> /etc/dhcp/dnsupdate.txt
nsupdate /etc/dhcp/dnsupdate.txt

echo "domain" $RESOLVEDOMAIN >> /etc/resolv.conf
