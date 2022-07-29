/usr/bin/env bash

# Author: zhai0122
# date: 2022/07/29
# Description: 显示一些系统信息

check_system() {
    if grep -i 'centos' /etc/os-release > /dev/null 2>&1 ; then
        release="centos"
    fi
}
main() {
    check_system;
    uptime | awk '{printf("\nSystem load: %.2f\t", $(NF-2))} NR==1{printf("Up: %s %s\t",$3,$4)} NR==1{printf("Users logged in: %s\n",$(NF-6))}'
    free -m | awk 'NR==2{printf("Memory usage: %s/%sMB %.2f%%\t", $3,$2,$3*100/$2)} NR==3{printf("Swap usage: %s/%sMB %.2f%%\n",$3,$2,$3*100/$2)}'
    df -h | awk '$NF=="/"{printf "Usage of /: %.1f/%.1fGB %s\t", $3,$2,$5}' ; ps -aux | wc -l | awk '{printf("Processes: %d\n", $1)}'
    ip addr | awk '$NF=="docker0"{printf "IPv4 address for docker0 : %s \n", $2} $NF=="eth0"{printf "IPv4 address for eth0 : %s \t", $2}'
    if [ "${release}" == "centos" ]; then
        lastlog -t 3 | awk 'NR==2{printf("Last Login: %s %s %s %s %s from %s\n\n",$1,$4,$5,$6,$7,$3)}'
    else
        last -3 | awk 'NR==2{printf("Last Login: \t%s %s %s %s from %s\n\n",$4,$5,$6,$7,$3)} NR==1{printf("Current Login: \t%s %s %s %s from %s\n",$4,$5,$6,$7,$3)}'
    fi
}
main