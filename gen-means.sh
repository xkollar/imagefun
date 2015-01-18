#!/usr/bin/env bash

PREFIX="median-"
SEQ_LENGTH=3

compare_with=${0};

num=1

ls ${PREFIX}* \
| sed -n 'H;g;s/.*\(\(\n[^\n]*\)\{'"${SEQ_LENGTH}"'\}\)$/\1/;h;y/\n/ /;s/^\s*//;p' \
| while read; do
    target="mean-$( printf "%04d" $num ).png"
    if ! [ -e "${target}" -a "${target}" -nt "${compare_with}" ]; then
        echo "Creating ${target}"
        convert $REPLY \
            -evaluate-sequence mean \
            "${target}"
    else
        echo "Skipping ${target}"
    fi
    let num+=1
done
