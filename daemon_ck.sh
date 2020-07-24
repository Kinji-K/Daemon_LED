#!/bin/bash
SERVICES=("sshd" "x11vnc" "vpnserver" "apache2" "smbd")

OUTPUT=`cat Filepath`

rm $OUTPUT
for SERVICE in ${SERVICES[@]}
do
    systemctl status $SERVICE | grep running
    if [ $? = 0 ]; then
        echo "$SERVICE 1" >> $OUTPUT  
    else
        echo "$SERVICE 0" >> $OUTPUT
    fi
done