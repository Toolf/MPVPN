# Dependency

- qemu
- qemu-kwm

# Create image
```
qemu-img create -f qcow2 Fedora-IoT-Iot-ostree-x86_64-35-20220101.0.qcow2 10G
```

# Run
```
sudo ipvirt-manager
source ./run.sh
```