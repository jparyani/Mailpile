#!/bin/sh

set -ex

export HOME=/var
export LANG=en_US.UTF-8

cd /var

if ! test -e mail; then
  mkdir -p mail/cur
  mkdir -p mail/new
  mkdir -p mail/tmp

  chmod -R 770 mail

  /usr/bin/python /mp --setup
  /usr/bin/python /mp --set sys.http_host=0.0.0.0
  /usr/bin/python /mp --add /var/mail/
  /usr/bin/python /mp --set prefs.rescan_interval=5
  /usr/bin/python /mp --set prefs.empty_outbox_interval=5
fi

/usr/bin/python /mp --rescan all
/usr/bin/python /mp --www