#!/bin/sh
# Locales
echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
localectl set-locale LANG=en_GB.UTF-8
localectl set-keymap uk

# NTP
useradd -d / -s /sbin/nologin -M -U -r systemd-timesync
echo "NTP=time1.ic.ac.uk time2.ic.ac.uk time3.ic.ac.uk" >> /etc/systemd/timesyncd.conf
timedatectl set-timezone Europe/London
timedatectl set-ntp true
hostnamectl set-hostname tc39-rpi-2

# Packages
pacman -Syu
pacman -S jack2 zita-ajbridge alsa-utils avahi ca-certificates sudo

# Avahi
ln -s /usr/share/doc/avahi/ssh.service /etc/avahi/services/
systemctl enable avahi-daemon
systemctl start avahi-daemon

# Users and login
echo "New root password:"
passwd
echo "%wheel      ALL=(ALL) ALL" > /etc/sudoers.d/wheel.conf
useradd -G audio,wheel -m thomas
mkdir /home/thomas/.ssh
cp authorized_keys /home/thomas/.ssh
chown -R thomas /home/thomas/.ssh
mkdir /root/.ssh
cp authorized_keys /root/.ssh

# Sound Config
cp 85-usb-mic.rules /etc/udev/rules.d/
cp {jackd-slave,jack-matchmaker,zita-ajbridge@}.service /etc/systemd/system
cp jack-matchmaker.conf /etc/
systemctl enable {jackd-slave,jack-matchmaker,zita-ajbridge@}.service
