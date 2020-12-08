#!/bin/bash
find /Auto/ -maxdepth 1 -type f -exec bash {} \;

export YDL_CONFIG_PATH=/usr/src/app/config_youtube-dl-server.yml
python -u /usr/src/app/youtube-dl-server.py &

tail -f /dev/null