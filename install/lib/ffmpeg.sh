#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### INCLUDES

source bash.inc.sh


### CONSTANT SETTINGS

# TODO(tamasviktorkrizsan): include 32-64 bit binary switch (avs support) in a later release (1.2)

PATH=/cygdrive/c/build_suite/local64/bin-video:$PATH;

declare -r FF_SCAN="-probesize 1000M -analyzeduration 1000M -noaccurate_seek";
