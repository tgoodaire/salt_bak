#!/bin/sh

# install salt
echo "Installing salt..."
sudo pkg install py27-salt

# configure salt
echo "Configuring salt..."
sudo sh -c "echo '192.168.1.200   salt' >> /etc/hosts"
sudo sysrc salt_master_enable="YES"

sudo sh -c "cat > /usr/local/etc/salt/master << EOF
interface: 192.168.1.200
hash_type: sha256
worker_threads: 10
timeout: 30
cli_summary: True
auto_accept: True

fileserver_backend:
  - roots

file_roots:
  base:
    - /srv/salt/

pillar_roots:
  base:
    - /srv/pillar
EOF
"
sudo sysrc salt_minion_enable="YES"
sudo service salt_master restart
sudo sh -c "cat > /usr/local/etc/salt/minion << EOF
master: salt
id: dahmer
hash_type: sha256
EOF
"
sudo service salt_minion stop
sudo salt-key -Dy
sudo service salt_minion start
sudo sed -i "" 's/auto_accept/\#auto_accept/g' /usr/local/etc/salt/master
sleep 10
sudo service salt_master restart

