#!/bin/sh

ws=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2`
i3-msg "workspace $ws; append_layout $HOME/,config/i3/ws-$ws.json"
