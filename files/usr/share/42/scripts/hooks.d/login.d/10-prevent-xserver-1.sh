#!/bin/bash

set -e

# Prevent starting user sessions on X-server :1
# This X-server is reserved for codam-web-greeter's lock screen
# User sessions should normally only start on X-server :0, but through student tinkering and/or bugs
# it is possible that a user session starts on :1, which breaks the lock screen functionality.
# If a user session starts on :1, their lock screen will be on :0. Then, upon screen unlock,
# the logout hook gets called, which assumes the user session was quit since X-server :0 was the one to call the logout hook.
if [ "$DISPLAY" = ":1" ]; then
	echo "Detected user session starting on X-server :1, which is reserved for codam-web-greeter's lock screen."
	echo "Exiting and restarting lightdm to prevent the user session from starting on X-server :1."
	/usr/bin/zenity --error --title="Login hook" --text="Error: attempted to start user session on X-server :1 instead of :0. Exiting to prevent issues. Try logging in again. If this keeps happening, contact the IT team (mention computer ${HOSTNAME})." --width=600 && /usr/bin/systemctl restart lightdm.service
	exit 1
fi
