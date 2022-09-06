#! /usr/bin/env bash

while true
do
	
	Bat_Pct=$(acpi -b | grep -P -o '[0-9]+(?=%)')
	Bat_Stat=$(acpi -b | grep -c "Charging")

	if [ "$Bat_Stat" -eq 1 ]; then	
		if [ "$Bat_Pct" -ge 80 ]; then
			dunstify -t 10000 -u normal "Battery full." "Level: ${Bat_Pct}% "
			#play /
		fi

	elif [ "$Bat_Stat" -eq 0 ]; then
		if [ "$Bat_Pct" -le 20 ]; then
			dunstify -t 10000 -u critical "Low Battery." "Level: ${Bat_Pct}%" "Plug the Charger!"
			#play /home/$USER/Music/Source/News-Intro.mp3

		elif [ "$Bat_Pct" -le 5 ]; then
			dunstify -t 1000 -u critical "Battery at Critical Level." "Suspending..."
			sleep 10
			systemctl suspend

		fi
	fi
	sleep 300
done
