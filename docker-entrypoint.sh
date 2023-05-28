#!/bin/bash

set -e
shopt -s extglob

if ! [ -e user/config/system.yaml ]; then
  echo >&2 "Copying Grav user files…"
  rsync -a /tmp/grav-admin/user/ /var/www/html/user
fi
chown -Rf www-data:www-data user || true
echo >&2 "Grav has been successfully installed."

exec "$@"
