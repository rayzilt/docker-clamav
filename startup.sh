#!/bin/bash

echo "Running freshclam to get latest definitions"
freshclam --user=clamav --stdout
status=$?
if [ ${status} -ne 0 ]; then
	echo "Couldn't download definitions... stopping."
	exit ${status}
fi

echo "Starting freshclam as daemon"
/usr/bin/freshclam --daemon --stdout &
status=$?
if [ ${status} -ne 0 ]; then
	echo "Failed to start freshclam... stopping."
        exit ${status}
fi

echo "Starting clamav as daemon"

mkdir -p /var/run/clamav
chown clamav:clamav /var/run/clamav

exec /usr/sbin/clamd 

