#!/bin/sh

natd -interface utun0
ipfw -f flush
ipfw add divert natd ip from any to any via utun0
ipfw add pass all from any to any
sysctl -w net.inet.ip.forwarding=1
