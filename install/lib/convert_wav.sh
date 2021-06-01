#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTION

####################################################################
# Convert the input audio file to WAV format.
# Arguments:
#   input file, track number, start timecode, end timecode,
#   audio channels, sample rate
# Outputs:
#   WAV file in the "OUTPUT" folder
####################################################################
function convert_wav () {


### INPUT PARAMETERS

## FFMPEG Stream Parameters (2-4)

declare usr_map=${2:-0};

declare usr_split_start=${3:-00:00:00.0};

declare usr_split_to=${4:-09:00:00.0};


## FFMPEG Audio Parameters (1,5-6)

declare usr_input=${1};

declare usr_audio_channels=${5:-2};

declare usr_sample_rate=${6:-44};


### INCLUDES

source ffmpeg.sh

source ffstream.sh

source ffaudio.sh


### CONSTANTS

declare -r WAV_COM="-c:a pcm_f32le -f wav";

declare -r FF_LOG_SUFFIX="_pipe_part1.log";


### PROCESSING

# parameter redirection

declare ffstream_com;

ffstream_com=$(concat_ffstream $usr_split_start $usr_split_to);

declare ffaudio_com;

ffaudio_com=$(concat_ffaudio $usr_map $usr_audio_channels $usr_sample_rate);


### EXECUTE COMMAND

declare input;

declare output;

input=$(handle_input "$usr_input");

for i in "$input";

do output=$(handle_output "$i");

ffmpeg $FF_SCAN -i "$i" $ffstream_com $ffaudio_com $WAV_COM $output.wav 2>&1 |\

tee "$output$FF_LOG_SUFFIX";

done;

}
