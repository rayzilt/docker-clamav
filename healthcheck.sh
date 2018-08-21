#!/bin/bash

if ! pgrep -x "clamd" > /dev/null; then
	echo "Clamd not running"
	exit 1
fi

if ! pgrep -x "freshclam" >/dev/nul; then
	echo "Freshclam not running"
	exit 1
fi

echo "Clamd and Freshclam are running"
exit 0
