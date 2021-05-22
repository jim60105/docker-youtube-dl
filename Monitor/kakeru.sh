#!/bin/bash

#
# File logging:
#####
mkdir -p /youtube-dl/logs
nohup /bin/bash live-dl https://www.youtube.com/channel/UCiLt4FLjMXszLOh5ISi1oqw &>/youtube-dl/logs/live-dl.$(date +%d%b%y-%H%M%S).log &

#
# STDOUT logging (with color):
#####
# nohup /bin/bash live-dl https://www.youtube.com/channel/UCiLt4FLjMXszLOh5ISi1oqw --log-color &

#
# STDOUT logging (with log tag):
#####
# nohup /bin/bash live-dl https://www.youtube.com/channel/UCiLt4FLjMXszLOh5ISi1oqw --log-tag 間取かける &
