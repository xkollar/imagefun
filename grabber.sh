#!/usr/bin/env bash

URL=http://www.hvezdarna.cz/kamera/kamera1920.jpg

starttime=$( date +%FT%T )
basename="camera-${starttime}-"

n=0;

currname="${basename}${n}.jpg"
wget "${URL}" -O "${currname}"

while true; do
    sleep 30
    currname="${basename}${n}.jpg"
    nextname="${basename}$((n+1)).jpg"
    wget "${URL}" -O "${nextname}"
    if diff -q "${nextname}" "${currname}"; then
        echo No difference...
        rm "${nextname}"
        continue
    fi
    echo New image...
    let n+=1
done
