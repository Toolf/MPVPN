#!/bin/bash

# Run this script on client host

declare -a delays = (1, 25, 50, 75, 100, 125, 150, 175, 200)
declare -a bindwidths = (10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
# set your interfaces
declare -a client_interfaces = ("enp0s3", "enp0s8", "enp0s9")
declare -a server_interfaces = ("enp0s3", "enp0s8", "enp0s9")

ssh root@172.16.4.1 iperf3 -s &
sleep 5 # wait for start iperf server

for delay in ${delays[@]}; do
    for bindwidth in ${bindwidths[@]}; do
        # setup for all interfaces on client
        for interface in ${client_interfaces[@]}; do
            exec "./client_qdisc_setup.sh $interface $bandwidth $delay"
        done
        # setup for all interfaces on server
        for interface in ${server_interfaces[@]}; do
            exec "./server_qdisc_setup.sh $interface $bandwidth $delay"
        done

        sleep 5

        iperf3 -c server_ip -t 60 >> "./data/$bandwidth:$delay_tcp.log"
        iperf3 -c server_ip -t 60 >> "./data/$bandwidth:$delay_udp.log"
    done
done