#!/bin/bash

exec -- 2>&1

set -x

docker ps -a
docker run --privileged -i alpine:latest <<'DOCKER'
apk add bash iproute2
bash <<'BASH'
set -x
id
ip netns add a
ip netns list
ip -n a link add d0 type dummy
ip -n a link set d0 up
ip -n a addr show
ip addr show
BASH
DOCKER

docker network list
docker run --privileged --network none --name testgentoo -d gentoo/stage3:latest /sbin/init
sleep 5
docker ps -a
docker logs testgentoo
docker exec -i testgentoo /bin/bash <<'DOCKER'
set -x
mount
rc-status
id
ip netns add a
ip netns list
ip -n a link add d0 type dummy
ip -n a link set d0 up
ip -n a addr show
ip addr show
DOCKER

pwd
#ls -lha
git branch
git status

sudo bash <<'BASH'
set -x

#apt-get install -y qemu-kvm cpu-checker

#cat /proc/cpuinfo
#lscpu
#kvm-ok
#which qemu-system-x86_64

#timeout 10 qemu-system-x86_64 -accel kvm -m 64M -nographic -vga none

uname -a
#env
#ps -ef

#ip netns add a
#ip netns list
#ip -n a link add d0 type dummy
#ip -n a link set d0 up
#ip -n a addr show
#ip addr show

ls -lha /boot

BASH
