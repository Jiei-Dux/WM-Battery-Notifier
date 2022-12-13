#! /usr/bin/bash

for pid in $(pgrep -f $0);
do
	if [ $pid != $$ ]; 
	then
		kill $pid
	fi
done

while true
do
	
	Bat_Pct=$(acpi -b | grep -P -o '[0-9]+(?=%)')
	Bat_Stat=$(acpi -b | grep -c "Charging")

	if [ "$Bat_Stat" -eq 1 ]; then	
		if [ "$Bat_Pct" -ge 80 ]; then
			dunstify -t 10000 -u normal "Battery full." "Level: ${Bat_Pct}% "
			#play /path/to/mp3/file
		fi

	elif [ "$Bat_Stat" -eq 0 ]; then
		if [ "$Bat_Pct" -le 25 ]; then
			dunstify -t 10000 -u critical "Low Battery." "Level: ${Bat_Pct}%" "Plug the Charger!"
			#play /path/to/mp3/file

		elif [ "$Bat_Pct" -le 15 ]; then
			dunstify -t 1000 -u critical "Battery at Critical Level." "Suspending..."
			sleep 10
			systemctl suspend

		fi
	fi
	sleep 1
done
