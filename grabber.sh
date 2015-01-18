#!/usr/bin/env bash

URL="${1:-http://www.hvezdarna.cz/kamera/kamera1920.jpg}"
PREFIX="${2:-camera-}"
SLEEPTIME=50

FETCH=( wget -q -O )

n=0;

prevname=$( ls -1r /dev/null ${PREFIX}* | head -n1 )

echo "Detected last from previous run: $prevname"

while true; do
    currname="${PREFIX}$( date -u +%FT%TZ ).jpg"
    "${FETCH[@]}" "${currname}" "${URL}"
    if diff -q "${prevname}" "${currname}" >/dev/null ; then
        echo "Nothing new..."
        rm "${currname}"
    else
        echo "New image '${currname}'"
        prevname="${currname}"
    fi
    sleep "${SLEEPTIME}"
done
