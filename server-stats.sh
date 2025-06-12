#!/bin/bash

echo "hello world"

echo "Total CPU usage"
top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1"%"}'

echo "Total Memory Usage"
top -bn1 | grep "MiB Mem" | \
            awk '{used=$8; total=$4; print "memory Used", (used/total)*100 "%\navailable memory", ((total-used)/total)*100 "%"}'

echo "Total Disk Usage"
df -h / | awk 'NR==2{print "Free",$4, " ", 100-$5 "%\n", "Used",$3," ",$5"%"}'

echo "Top 5 processes by CPU usage"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

echo "Top 5 processes by Memory usage"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

echo "OS version"
cat /etc/os-release | grep PRETTY_NAME | cut -d '=' -f2 | tr -d '"' 

echo "Kernel version"
uname -r

echo "Uptime"
uptime | awk -F', ' '{print $1}'

echo "Load Average"
uptime | awk -F'load average:' '{ print $2 }'