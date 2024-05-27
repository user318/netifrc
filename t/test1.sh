#!/bin/bash

set -x

docker ps
docker run -i alpine:latest <<'DOCKER'
apk add bash iproute2
bash <<'BASH'
set -x
ip netns add a
ip netns list
ip -n a link add d0 type dummy
ip -n a link set d0 up
ip -n a addr show
ip addr show
BASH
DOCKER

cat /proc/cpuinfo
env
ps -ef

pwd
ls -lha
git branch
git status

ip netns add a
ip netns list
ip -n a link add d0 type dummy
ip -n a link set d0 up
ip -n a addr show
ip addr show
