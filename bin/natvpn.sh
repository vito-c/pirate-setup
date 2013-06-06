#!/bin/sh

natd -interface jnc0
ipfw -f flush
ipfw add divert natd ip from any to any via jnc0
ipfw add pass all from any to any
sysctl -w net.inet.ip.forwarding=1
