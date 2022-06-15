declare -a delays = (1 50 100 150 200)
declare -a bandwidths = (10 20 30 40 50 60 70 80 90 100)
declare -a loss_rate = (1 2 3 4 5 6 7 8 9 10)
# set your interfaces
declare -a client_interfaces = ("enp0s3" "enp0s8")
declare -a server_interfaces = ("enp0s3" "enp0s8")

for delay in ${delays[@]}; do
    for bandwidth in ${bandwidths[@]}; do
        for loss in ${loss_rate[@]}; do
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
                ./client_qdisc_setup.sh $interface $bandwidth $delay $loss
            done
            # setup for all interfaces on server
            for interface in ${server_interfaces[@]}; do
                ./server_qdisc_setup.sh $interface $bandwidth $delay $loss
            done

            iperf3 -c 10.0.0.1 -t 60 > "./data/openvpn/loss/$bandwidth:$delay:$loss.log"
        done
    done
done