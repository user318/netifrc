#!/bin/bash

exec -- 2>&1
set -x

docker network list
docker run --privileged --network none --name test1 -d test-gentoo /sbin/init
sleep 5
docker ps -a
docker logs test1
docker exec -i test1 /bin/bash <<'DOCKER'
set -x
mount
rc-status
qlist -v netifrc
qfile -v /etc/init.d/net.lo
id
ip netns add a
ip netns list
ip -n a link add d0 type dummy
ip -n a link set d0 up
ip -n a addr show
ip addr show
DOCKER

cd t && clab deploy

docker exec -i clab-t1-g1 <<'DOCKER'
set -x
ip addr show
ip link set eth0 up
ip addr add 192.168.0.1/24 dev eth0
ip addr show
DOCKER

docker exec -i clab-t1-g2 <<'DOCKER'
set -x
ip addr show
ip link set eth0 up
ip addr add 192.168.0.2/24 dev eth0
ip addr show
ping -c4 192.168.0.1
DOCKER

echo finish
