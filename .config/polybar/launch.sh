#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

export WLAN_INTERFACE=wlp32s0

# Launch bar1 and bar2
export MONITOR_HDMI="HDMI-A-0"
export MONITOR_DVI="DVI-D-0"
polybar hdmitop &
polybar hdmibot &
polybar dvitop &
polybar dvibot &


echo "Bars launched..."
