#!/bin/bash

tc qdisc del dev enp0s3 root || true
tc qdisc del dev enp0s8 root || true
tc qdisc del dev enp0s9 root || true