#!/bin/bash

# Prune before the second download.
/bin/bash prune_dir.sh /youtube-dl ${DelPercentage} > /proc/1/fd/1

# Sleep one minute to make sure the live stream is end.
echo "[$(date +"%D %T")] [Callback] [Info] Download again after 60 seconds..." > /proc/1/fd/1
sleep 60

# Download again.
#
# File logging:
#####
mkdir -p /youtube-dl/logs
/bin/bash live-dl --callback "/dev/null" https://www.youtube.com/watch?v=$3 --log-tag Callback &>"/youtube-dl/logs/live-dl-callback-$3.log"

#
# Docker logs logging (with log tag):
#####
# /bin/bash live-dl --callback "/dev/null" https://www.youtube.com/watch?v=$3 --log-tag Callback > /proc/1/fd/1

echo "[$(date +"%D %T")] [Callback] [Info] Callback finished." > /proc/1/fd/1