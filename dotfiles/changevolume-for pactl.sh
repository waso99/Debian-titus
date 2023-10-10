#!/bin/sh

# Increment, decrement, or mute the volume and send a notification
# of the current volume level.

send_notification() {
	volume=$(pactl list sinks | grep -i volume | head -1 | awk '{print $5}' | sed -e 's/%//')
	dunstify -a "changevolume" -u low -r 9993 -h int:value:"$volume" -i "volume-$1" "Volume: ${volume}%" -t 2000
}

case $1 in
up)
	# Set the volume on (if it was muted)
	pactl set-sink-mute @DEFAULT_SINK@ false
	pactl set-sink-volume 0 +5%
	send_notification "$1"
	;;
down)
	pactl set-sink-mute @DEFAULT_SINK@ false
	pactl set-sink-volume 0 -5%
	send_notification "$1"
	;;
mute)
	pactl set-sink-mute 0 toggle
	if [ `pactl list sinks  | grep Mute | awk '{print $2}'` = 'yes' ]; then	
		dunstify -a "changevolume" -t 2000 -r 9993 -u low -i "volume-mute" "Muted"
	else
		send_notification up
	fi
	;;
esac