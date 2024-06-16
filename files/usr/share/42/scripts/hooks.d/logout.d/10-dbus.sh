#!/bin/bash

set -e

# Uncache user
/usr/bin/dbus-send --system --print-reply --dest=org.freedesktop.Accounts /org/freedesktop/Accounts org.freedesktop.Accounts.UncacheUser string:$USER || true
