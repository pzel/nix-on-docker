#!/bin/sh
echo '' >> /etc/ssh/sshd_config
echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
mkdir -p /var/run/sshd
chmod 755 /var/run/sshd
# run nix-deamin
exec /usr/sbin/sshd -D

