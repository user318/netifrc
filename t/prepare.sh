#!/bin/bash

exec -- 2>&1
set -x

# Build docker images
docker build -t test-gentoo -f t/Dockerfile.gentoo .

# Install containerlab
echo "deb [trusted=yes] https://apt.fury.io/netdevops/ /" | \
sudo tee -a /etc/apt/sources.list.d/netdevops.list
sudo apt update && sudo apt install containerlab
