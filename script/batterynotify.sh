#!/bin/sh
# Send a notification if the laptop battery is either low 
# or is fully charged.
########### add it as schedule to (crontab) :(*/5 * * * * /home/waso/.local/bin/batterynotify.sh)
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
# Battery percentage at which to notify
WARNING_LEVEL=90
#BATTERY_DISCHARGING=$(cat /sys/class/power_supply/BAT1/status)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)
#BATTERY_STATUS="Discharging"
BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)

#if  STATUS=="Charging" ; then
#    BATTERY_STATUS="Charging"
#  elif STATUS=="Discharging" ; then
#    BATTERY_STATUS='Discharging'
#  fi

# Use two files to store whether we've shown a notification or not (to prevent multiple notifications)
EMPTY_FILE=/tmp/batteryempty
FULL_FILE=/tmp/batteryfull

# Reset notifications if the computer is charging/discharging
if [ "$BATTERY_STATUS" = 'Charging' ] && [ -f $FULL_FILE ]; then
    rm $FULL_FILE
elif [ "$BATTERY_STATUS" = 'Discharging' ] && [ -f $EMPTY_FILE ]; then
    rm $EMPTY_FILE
fi

# If the battery is low and is not charging (and has not shown notification yet)
if [ "$BATTERY_LEVEL" -le $WARNING_LEVEL ] && [ "$BATTERY_STATUS" = 'Discharging' ] && [ ! -f $EMPTY_FILE ]; then
    notify-send "Low Battery" "${BATTERY_LEVEL}% of battery remaining." -u critical -i "battery-alert" -r 9991
    touch $EMPTY_FILE
# If the battery is charging and is full (and has not shown notification yet)    
elif [ "$BATTERY_LEVEL" -gt 95 ] && [ "$BATTERY_STATUS" = 'Charging' ] && [ ! -f $FULL_FILE ]; then
    notify-send "Battery Charged" "Battery is fully charged." -i "battery" -r 9991
    touch $FULL_FILE
fi

