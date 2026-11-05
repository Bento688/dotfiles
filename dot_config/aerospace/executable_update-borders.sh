#!/bin/bash

APP_ID=$(aerospace list-windows --focused --format '%{app-bundle-id}')

if [ "$APP_ID" = "com.mitchellh.ghostty" ]; then
    borders active_color=0xffa8d2b2 inactive_color=0xff4b565c style=square order=below width=8.0 blacklist="Firefox"
else
    borders active_color=0xffa8d2b2 inactive_color=0xff4b565c style=round order=below width=4.0 blacklist="Firefox"
fi
