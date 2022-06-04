# enp0s3
ip route add table enp0s8 to 172.16.3.0/24 dev enp0s3 scope link

# enp0s8
ip route add table enp0s8 to 172.16.4.0/24 dev enp0s8 scope link

ip route add table enp0s8 default via 172.16.1.4 dev enp0s8
ip rule add from 172.16.1.4 table enp0s8

# enp0s9
ip route add table enp0s9 to 172.16.2.0/24 dev enp0s9 scope link

ip route add table enp0s9 default via 172.16.2.4 dev enp0s9
ip rule add from 172.16.2.4 table enp0s9