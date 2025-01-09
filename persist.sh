#!/bin/vbash

# basic script to put a fix into place on a VyOS router VM in environments where it's 
# cloned (and not lose config due to new UUID and MAC addresses on interfaces)
# 3 minutes after reboot, we'll run these commands via a crontab entry. logging output
# needs help as output gets lost for some reason.

source /opt/vyatta/etc/functions/script-template

# make sure script is run as group vyattacfg
if [ 'vyattacfg' != $(id -ng) ]; then
 exec sg vyattacfg -c "$0 $@"
fi

echo BEGIN &>> /home/vyos/log/persist.log

date &>> /home/vyos/log/persist.log

configure &>> /home/vyos/log/persist.log
delete interfaces ethernet eth0 hw-id &>> /home/vyos/log/persist.log
delete interfaces ethernet eth1 hw-id &>> /home/vyos/log/persist.log
delete interfaces ethernet eth2 hw-id &>> /home/vyos/log/persist.log
delete interfaces ethernet eth3 hw-id &>> /home/vyos/log/persist.log
delete interfaces ethernet eth4 hw-id &>> /home/vyos/log/persist.log
delete interfaces ethernet eth5 hw-id &>> /home/vyos/log/persist.log
delete interfaces ethernet eth6 hw-id &>> /home/vyos/log/persist.log
delete interfaces ethernet eth7 hw-id &>> /home/vyos/log/persist.log
delete interfaces ethernet eth8 hw-id &>> /home/vyos/log/persist.log
delete interfaces ethernet eth9 hw-id &>> /home/vyos/log/persist.log
commit &>> /home/vyos/log/persist.log
save &>> /home/vyos/log/persist.log
echo END &>> /home/vyos/log/persist.log
echo ============================== &>> /home/vyos/log/persist.log
exit
#sudo poweroff