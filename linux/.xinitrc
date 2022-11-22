#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#notification forwarder
dbus-monitor "interface='org.freedesktop.Notifications'" | grep --line-buffered "string" | grep --line-buffered -e method -e ":" -e '""' -e urgency -e notify -v | grep --line-buffered '.*(?=string)|(?<=string).*' -oPi | grep --line-buffered -v '^\s*$' | xargs -I '{}' /bin/bash /home/thomas/scripts/notification-forwarding.sh {} &

exec startxfce4
