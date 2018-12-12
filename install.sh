#!/bin/bash
################
# Install Docker
################

echo "Installing and configuring Docker"



installDocker()
        {
        for i in {1..10}; do
                wget --tries 4 --retry-connrefused --waitretry=15 -qO- https://get.docker.com | sh
                if [ $? -eq 0 ]
                then
                        # hostname has been found continue
                        echo "Docker installed successfully"
                        break
                fi
                sleep 10
        done
        }
time installDocker
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#############
# Install App
#############

mkdir -p ~/agr
cd ~/agr
git clone https://github.com/aggregion/agr.git
cd ~/agr/agr/Docker
cat /root/keys config.sample.ini >> config.ini
docker volume create nodagr-data-volume
docker volume create kagrd-data-volume
docker-compose -f docker-compose.yml up -d >> /var/log/agr_node_install.log
