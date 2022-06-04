#!/bin/bash

# arguments description
# $1: network interface name (look ifconfig)
# $2: bandwidth
# $3: deley

ssh root@172.16.4.1 exec "/scripts/qdisc_clear.sh"

ssh root@172.16.4.1 tc qdisc add dev $1 root handle 1:0 tbf rate $2mbit burst 16000 latency 5ms
ssh root@172.16.4.1 tc qdisc add dev $1 parent 1:1 handle 10: netem delay $3ms