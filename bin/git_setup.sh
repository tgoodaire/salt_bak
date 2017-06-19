#!/bin/sh
if [ $(whoami) != 'root' ]; then
    echo "Must be run as root"
    exit 1
fi
pkg install sudo
if [ $? -ne 0 ]; then
    echo "Unable to install sudo"
    exit 1
fi

cat > /usr/local/etc/sudoers << EOF
root ALL=(ALL) ALL
%wheel ALL=(ALL) NOPASSWD
EOF

pw groupmod wheel -m tim
if [ $? -ne 0 ]; then
    echo "Unable to add tim to wheel group"
    exit 1
fi
pkg install git
if [ $? -ne 0 ]; then
    echo "Unable to install git client"
    exit 1
fi
 mkdir -p /srv/salt
if [ $? -ne 0 ]; then
    echo "Unable to create /srv/salt"
    exit 1
fi
if [ ! -f /srv/salt/.git/config ]; then
    git clone git@github.com:tgoodaire/salt.git /srv/salt
fi

