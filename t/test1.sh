#!/bin/bash

exec -- 2>&1

set -x

docker ps
docker run -i alpine:latest <<'DOCKER'
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

pwd
ls -lha
git branch
git status

sudo bash <<'BASH'
set -x

#cat /proc/cpuinfo
lscpu
kvm-ok
which qemu
uname -a
#env
#ps -ef

ip netns add a
ip netns list
ip -n a link add d0 type dummy
ip -n a link set d0 up
ip -n a addr show
ip addr show

BASH
