#!/bin/sh

# Disable logging overheads
echo "Storage=volatile" >> /etc/systemd/journald.conf
echo "RuntimeMaxUse=20M" >> /etc/systemd/journald.conf
echo "* hard core 0" > /etc/security/limits.d/50-coredump-disable.conf
echo "kernel.core_pattern=|/bin/false" >> /etc/sysctl.d/50-coredump.conf

# /var/log to tmpfs
echo "tmpfs /var/log tmpfs defaults,size=50m,nosuid,noatime,mode=0755 0 0" >> /etc/fstab
mv /var/log/wtmp /
rm -Rf /var/log/*
mount /var/log
mv /wtmp /var/log

# Fix default hardware config
rm /etc/modules-load.d/raspberrypi.conf
systemctl stop haveged
systemctl disable haveged
pacman -Rsc haveged
pacman -S rng-tools
echo 'RNGD_OPTS="-o /dev/random -r /dev/hwrng"' >> /etc/conf.d/rngd
systemctl enable rngd
systemctl start rngd

# Remove lvm2 overheads
systemctl stop lvm2-lvmpolld.socket lvm2-lvmpolld lvm2-lvmetad.socket lvm2-lvmetad lvm2-monitor
systemctl disable lvm2-lvmpolld.socket lvm2-lvmpolld lvm2-lvmetad.socket lvm2-lvmetad lvm2-monitor
pacman -Rsc lvm2

# Disable scheduled tasks
systemctl stop man-db.timer
systemctl disable man-db.timer
systemctl stop cronie || true
systemctl disable cronie || true
pacman -Rsc cronie || true

