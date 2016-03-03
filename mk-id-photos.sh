#!/usr/bin/env bash
#
# Generate image suitable for printing on photopapaper of size 10x15 cm
# so that 2x4 photos of 3.5x4.5 cm can be cut with safety of 1mm on each side.
# There is also white border or remaining space.
#
# Usage: $progname [SRC_IMG] [DST_IMG]
#
# For 300 DPI:
# X at least 300*35/24.5 = 429
# y at least 300*45/24.5 = 552

set -eu

readonly COEF=20
readonly FREE=1
readonly RESOLUTION=$((COEF * (35 + 2*FREE)))x$((COEF * (45 + 2*FREE)))
readonly BODERR=$((COEF * (10 - 4*2*FREE)))
readonly BODERB=$((COEF * (10 - 2*2*FREE)))

function main() {
  readonly img_in=${1}
  readonly img_out=${2}

  readonly tmp=$( mktemp -d )

  convert "${img_in}" \
    -auto-orient \
    -gravity Center \
    -resize "${RESOLUTION}^" \
    -extent "${RESOLUTION}" \
    \( +clone +clone +clone \) +append \
    \( +clone \) -append \
    -gravity southeast -splice "${BODERR}x${BODERB}" \
    -fill white -stroke black  -font "Bookman-Demi" -pointsize 20 \
    -gravity southwest  -annotate 0 ' ID Photo: 35mm x 45mm (+1mm boder on each side)\n' \
    "${img_out}"

  rm -rf "${tmp}"
}

main "${@}"
