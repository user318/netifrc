#!/bin/bash

exec -- 2>&1

set -x

docker build -t test-gentoo -f t/Dockerfile.gentoo .

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

uname -a
ls -lha /boot
