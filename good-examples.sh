exit 1

num=1
ls *jpg \
| sed -n 'H;g;s/.*\(\(\n[^\n]*\)\{7\}\)$/\1/;h;y/\n/ /;s/^\s*//;p' \
| while read; do
    convert $REPLY -scale 800x600 \
        -colorspace LMS \
            -evaluate-sequence median \
            \( +clone -colorspace Log -separate -normalize -combine -colorspace LMS \) \
            \( -clone 0 -equalize \) \
            -evaluate-sequence mean \
        -colorspace RGB \
        median-$( printf "%03d" $num ).png
    let num+=1
done

exit 1

num=1
ls *jpg \
| sed -n 'H;g;s/.*\(\(\n[^\n]*\)\{7\}\)$/\1/;h;y/\n/ /;s/^\s*//;p' \
| while read; do
    convert $REPLY -scale 800x600 \
        -colorspace LMS \
            -evaluate-sequence median \
        -colorspace RGB \
        -auto-gamma \
        median-$( printf "%03d" $num ).png
    let num+=1
done
