#!/bin/sh
if [ $(whoami) != 'root' ]; then
    echo "Must be run as root"
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
git clone git@github.com:tgoodaire/salt.git /srv/salt
if [ $? -ne 0 ]; then
    echo "Unable to checkout salt repo"
    exit 1
fi

