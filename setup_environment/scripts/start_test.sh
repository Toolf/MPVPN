#!/bin/bash

# Run this script on client host

declare -a delays = (1 25 50 75 100 125 150 175 200)
declare -a bandwidths = (10 20 30 40 50 60 70 80 90 100)
# set your interfaces
declare -a client_interfaces = ("enp0s3" "enp0s8")
declare -a server_interfaces = ("enp0s3" "enp0s8")

ssh root@172.16.4.1 iperf3 -s &
ssh root@172.16.4.1 netserver &
sleep 5 # wait for start iperf server and netserver


for delay in ${delays[@]}; do
    for bandwidth in ${bandwidths[@]}; do
        echo "delay: $delay, bandwidth: $bandwidth"

        #clear qdics
        for interface in ${client_interfaces[@]}; do
            tc qdisc del dev $interface root
        done
        for interface in ${client_interfaces[@]}; do
            ssh root@172.16.4.1 tc qdisc del dev $interface root
        done


        # setup for all interfaces on client
        for interface in ${client_interfaces[@]}; do
            exec "./client_qdisc_setup.sh $interface $bandwidth $delay 0"
        done
        # setup for all interfaces on server
        for interface in ${server_interfaces[@]}; do
            exec "./server_qdisc_setup.sh $interface $bandwidth $delay 0"
        done

        sleep 5

        iperf3 -c 10.0.0.1 -t 60 > "./data/$bandwidth:$delay_tcp.log"
        netperf -t tcp_rr -H 10.0.0.1 -l 40 -- -r 1,1 -o stddev_letency | sed -n 3p > "./data/$bandwidth:$delay_latency.log"
    done
done