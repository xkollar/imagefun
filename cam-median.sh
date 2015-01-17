#!/usr/bin/env bash

tmp=$( mktemp -d)

mplayer -really-quiet tv:// -frames 60 -fps 15 -vo png:outdir=$tmp
convert $tmp/* -evaluate-sequence median "median-$( date +%FT%T ).png"

rm -rf $tmp
