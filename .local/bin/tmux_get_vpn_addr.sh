#!/bin/sh

ip addr show dev tun0 > /dev/null 2>&1

if [ $? -gt 0 ]
then
    echo 'Disconnected'
else
    echo `ip addr show dev tun0 | grep inet | grep tun0 | awk '{print $2}'`
fi
