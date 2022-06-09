#!/bin/bash

# arguments description
# $1: network interface name (look ifconfig)
# $2: bandwidth
# $3: deley
# $4: loss rate

# clear
tc qdisc del dev $1 root || true

# setup
tc qdisc add dev $1 root handle 1:0 tbf rate $2mbit burst 16000 latency 5ms
tc qdisc add dev $1 parent 1:1 handle 10: netem delay $3ms loss $4%