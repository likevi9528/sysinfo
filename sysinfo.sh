/usr/bin/env bash

# Author: zhai0122
# date: 2022/07/29
# Description: 显示一些系统信息
uptime | awk '{printf("System load: %.2f\t", $(NF-2))} NR==1{printf("Up: %s %s\t",$3,$4)} NR==1{printf("Users logged in: %s\n",$(NF-6))}'
ps -aux | wc -l | awk '{printf("Processes: %d\n", $1)}'
free -m | awk 'NR==2{printf("Memory usage: %s/%sMB %.2f%%\n", $3,$2,$3*100/$2)} NR==3{printf("Swap usage: %s/%sMB %.2f%%\n",$3,$2,$3*100/$2)}'
df -h | awk '$NF=="/"{printf "Usage of /: %.1f/%.1fGB %s\n\n", $3,$2,$5}'
ip addr | awk '$NF=="docker0"{printf "IPv4 address for docker0 : %s \t", $(NF-5)} $NF=="eth0"{printf "IPv4 address for eth0 : %s \n", $(NF-5)}'