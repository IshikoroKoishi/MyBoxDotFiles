#!/bin/sh

ws=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2`
i3-save-tree --workspace $ws > $HOME/.config/i3/ws-$ws.json
