#!/bin/bash

# Prune before the second download.
/bin/bash prune_dir.sh /youtube-dl ${DelPercentage}

# Sleep one minute to make sure the live stream is end.
sleep 60

# Download again.
#
# File logging:
#####
# mkdir -p /youtube-dl/logs
# /bin/bash live-dl --callback "/dev/null" https://www.youtube.com/watch?v=$3 &>"/youtube-dl/logs/live-dl-callback-$3.log"

#
# STDOUT logging (with log tag):
#####
/bin/bash live-dl --callback "/dev/null" https://www.youtube.com/watch?v=$3 --log-tag Callback &
