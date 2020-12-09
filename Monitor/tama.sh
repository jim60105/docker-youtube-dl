#!/bin/bash

# Make folder if not exist
mkdir -p /youtube-dl/logs

#Change the URL link and the name of the log file.
nohup /bin/bash live-dl https://www.youtube.com/channel/UCBC7vYFNQoGPupe5NxPG4Bw &>/youtube-dl/logs/live-dl-tama.$(date +%d%b%y-%H%M%S).log &