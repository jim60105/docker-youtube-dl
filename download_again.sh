#!/bin/bash

# Prune before the second download.
/bin/bash prune_dir.sh /youtube-dl ${DelPercentage}

# Sleep one minute to make sure the live stream is end.
sleep 60

# Make folder if not exist
mkdir -p /youtube-dl/logs

# Download again.
/bin/bash live-dl --callback false https://www.youtube.com/watch?v=$3 &>"/youtube-dl/logs/live-dl-callback-$3.log"
