# enp0s3

ip route add table 101 to 172.16.3.0/24 dev enp0s3 metric 200
ip route add table 101 default via 172.16.3.4 dev enp0s3
ip rule add from 172.16.3.4 table 101

# enp0s8
ip route add table 102 to 172.16.4.0/24 dev enp0s8 metric 200
ip route add table 102 default via 172.16.4.4 dev enp0s8
ip rule add from 172.16.4.4 table 102