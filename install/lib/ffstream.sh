#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

#########################################################################
# Concat ffmpeg stream command string.
# Arguments:
#   The input file's track number, start time code, end time code
# Returns:
#   Concatenated ffmpeg stream command string
#########################################################################
function concat_ffstream () {


declare usr_map=${1:-0};

declare usr_split_start=${2:-00:00:00.0};

declare usr_split_to=${3:-09:00:00.0};


#### INCLUDES

source timecode.sh


### PROCESSING

declare split_duration;

split_duration=$(subtract_timecode $usr_split_start $usr_split_to);


declare stream="-ss $usr_split_start -to $split_duration -map 0:$usr_map -threads 0 -y";

echo "$stream";

}
