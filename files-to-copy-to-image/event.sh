#!/bin/bash
if test -f /etc/X11/xorg.conf.d/10-input.conf
then
   rm /etc/X11/xorg.conf.d/10-input.conf
fi
# create new input device file
cat > /etc/X11/xorg.conf.d/10-input.conf <<_EOF_
Section "ServerFlags"
     Option "AutoAddDevices" "False"
EndSection
_EOF_

# add input devices and their events to X11 configuration
cd /dev/input
for input in event*
do
cat >> /etc/X11/xorg.conf.d/10-input.conf <<_EOF_
    Section "InputDevice"
    Identifier "$input"
    Option "Device" "/dev/input/$input"
    Option "AutoServerLayout" "true"
    Driver "evdev"
EndSection
_EOF_
done

startx -- vt2
