#!/bin/bash

# Sleep one minute to make sure the live stream is end.
sleep 60

# Make folder if not exist
mkdir -p /youtube-dl/logs

#Change the URL link and the name of the log file.
nohup /bin/bash live-dl https://www.youtube.com/watch?v=$3 &>/youtube-dl/logs/live-dl-again$4.$(date +%d%b%y-%H%M%S).log &