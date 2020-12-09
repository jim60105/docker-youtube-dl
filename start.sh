#!/bin/bash
find /Monitor/ -maxdepth 1 -type f -exec bash {} \;

tail -f /dev/null