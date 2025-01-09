#!/bin/bash

# basic script to put a fix into place on a VyOS router VM in environments where it's 
# cloned (and not lose config due to new UUID and MAC addresses on interfaces). ONLY 
# run this on a VyOS router. Tested on v1.4.x nightly builds.

# write out current crontab
crontab -l > newcron
# echo new cron into cron file - 3 minutes after reboot, we'll run these commands. 
echo "@reboot sleep 180 && /usr/local/sbin/persist.sh" >> newcron
# install new cron file
crontab newcron
# do the newcron dance
rm newcron
# create custom config path for VyOS
mkdir -p /config/custom
# move persistence VyOS command script into place
cp persist.sh /config/custom
# fix ownership
chown -R root:vyattacfg /config/custom/persist.sh 
# make it execuatle
chmod +x /config/custom/persist.sh
# add sh script to command path
cd /usr/local/sbin
# put symlink in there
ln -s /config/custom/persist.sh ./persist.sh
# create logfile path
mkdir -p /home/vyos/log
# create logfile
touch /home/vyos/log/persist.log
# set logfile permissions
chown -R vyos:users /home/vyos/log/persist.log
