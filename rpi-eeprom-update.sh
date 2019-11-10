#/bin/bash -e

if [ ! -d /opt/vc/bin ]; then
	echo Please install raspberrypi-firmware package first >&2
	exit 1
fi

SCRIPT_NAME=${0##*/}

if [ -x /usr/lib/rpi-eeprom/${SCRIPT_NAME} ]; then
	env PATH=${PATH}:/opt/vc/bin /usr/lib/rpi-eeprom/${SCRIPT_NAME} "$@"
else
	echo Script /usr/lib/rpi-eeprom/${SCRIPT_NAME} not found >&2
	exit 1
fi
