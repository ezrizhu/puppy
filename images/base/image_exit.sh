#!/bin/sh

export LANG=C LC_CTYPE=C

set -x
dnf clean all
rm -f /var/lib/dbus/machine-id
truncate -s0 /etc/machine-id
