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


### INPUT PARAMETERS

declare usr_split_start="${1:-00:00:00.0}";

declare usr_split_to="${2:-09:00:00.0}";


#### INCLUDES

source timecode.sh


### PROCESSING

declare split_duration;

split_duration=$(subtract_timecode $usr_split_start $usr_split_to);

declare stream_com="-ss $usr_split_start -to $split_duration -threads 0 -y";


### RETURN

echo "$stream_com";

}
