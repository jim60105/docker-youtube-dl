#!/bin/bash

#
# File logging:
#####
mkdir -p /youtube-dl/logs
nohup /bin/bash live-dl https://www.youtube.com/channel/UCBC7vYFNQoGPupe5NxPG4Bw &>/youtube-dl/logs/live-dl.$(date +%d%b%y-%H%M%S).log &

#
# STDOUT logging (with color):
#####
# nohup /bin/bash live-dl https://www.youtube.com/channel/UCBC7vYFNQoGPupe5NxPG4Bw --log-color &

#
# STDOUT logging (with log tag):
#####
# nohup /bin/bash live-dl https://www.youtube.com/channel/UCBC7vYFNQoGPupe5NxPG4Bw --log-tag 久遠たま &