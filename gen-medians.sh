#!/usr/bin/env bash

PREFIX="camera-"
SEQ_LENGTH=10

compare_with=${0};

num=1

ls ${PREFIX}* \
| sed -n 'H;g;s/.*\(\(\n[^\n]*\)\{'"${SEQ_LENGTH}"'\}\)$/\1/;h;y/\n/ /;s/^\s*//;p' \
| while read; do
    target="median-$( printf "%04d" $num ).png"
    if ! [ -e "${target}" -a "${target}" -nt "${compare_with}" ]; then
        echo "Creating ${target}"
        convert $REPLY -scale 800x600 \
            -colorspace LMS \
                -evaluate-sequence median \
            -colorspace RGB \
            \( +clone -colorspace Log -gamma 1.7 -colorspace RGB \) \
            -compose soft-light -composite \
            "${target}"
    else
        echo "Skipping ${target}"
    fi
    let num+=1
done
