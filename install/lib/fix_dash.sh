#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTION

###############################################################
# remove the m4a DASH segmentation by copying the audio stream
# into a new file. Thus, Making the file more compatible for
# consumer devices. Use it in conjuction with youtube-dl
# scripts.
# Arguments:
#   input file, start timecode, end timecode
###############################################################
function fix_dash () {


### INPUT PARAMETERS

declare usr_input=${1};

declare usr_split_start=${2:-00:00:00.0};

declare usr_split_to=${3:-09:00:00.0};


### INCLUDES

source ffmpeg.sh

source ffstream.sh


### PIPE PART 1 - FFMPEG SETTINGS

## Constant Settings

declare -xr DEFAULT_INPUT='*.m4a';

declare -r M4A_COM="-vn -c:a copy";

declare -r FF_LOG_SUFFIX=".log";


## Processing

declare ffstream_com;

ffstream_com=$(concat_ffstream $usr_split_start $usr_split_to);


### EXECUTING COMMAND

declare input;

declare output;

input=$(handle_input "$usr_input");

for i in "$input";

do output=$(handle_output "$i" "M4A_FIXED");

ffmpeg $FF_SCAN -i "$i" $ff_stream_com $M4A_COM "$output.m4a" 2>&1 |\

tee "$output$FF_LOG_SUFFIX";

done;

}
