#! /bin/zsh
act=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
max=$(cat /sys/class/backlight/intel_backlight/max_brightness)

progress=$(( $act * 10 / $max ))

bar=""

if [ $progress -gt 1 ]; then
    for i in {2..$progress}
    do
        bar+="-"
    done
fi

bar+="|"

if [ $progress -lt 10 ]; then
    for i in {$progress..9}
    do
        bar+="-"
    done
fi

echo $progress
