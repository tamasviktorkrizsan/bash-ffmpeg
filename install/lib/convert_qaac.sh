#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTION

#############################################################
# Convert input audio to m4a/aac file (qaac codec)
# placed in the "OUTPUT" folder.
# Arguments:
#   input file, track number, start timecode, end timecode,
#   audio channels, sample rate, rate control,bitrate,
#   output extension
#############################################################
function convert_qaac () {


### INPUT PARAMETERS

## FFMPEG Stream Parameter Processing (2-4)

declare usr_map=${2:-0};

declare usr_split_start=${3:-00:00:00.0};

declare usr_split_to=${4:-09:00:00.0};


## FFMPEG Audio Parameter Processing (1,5-6)

declare usr_input=${1};

declare usr_audio_channels=${5:-2};

declare usr_sample_rate=${6:-44};


### QAAC Codec Parameter Processing (1,5-6)

declare usr_rate_control=${7:-vbr};

declare usr_bitrate=${8:-127};

declare usr_output_extension=${9:-m4a};


### INCLUDES

source ffmpeg.sh

source ffstream.sh

source ffaudio.sh


### PIPE PART 1 - FFMPEG SETTINGS

## Constant Settings

declare -r WAV_COM="-c:a pcm_f32le -f wav -";

declare -r FF_LOG_SUFFIX="_pipe_part1.log";


## Processing

declare ffstream_com;

ffstream_com=$(concat_ffstream $usr_map $usr_split_start $usr_split_to);

declare ffaudio_com;

ffaudio_com=$(concat_ffaudio $usr_audio_channels $usr_sample_rate )



### PIPE PART 2 - QAAC SETTINGS

## Constant Settings

PATH=/cygdrive/c/cygwin64/usr/local/bin:$PATH;

declare -r QCONFIG="--verbose --threading --ignorelength --quality 2";

declare -r QLOG_SUFFIX="_pipe_part2.log";


## Processing

case $usr_rate_control in


  "vbr")
	  qrate_control="--tvbr";;

  "cvbr_he")
	  qrate_control="--cvbr --he";;

  "abr")
    qrate_control="--abr";;

  "abr_he")
    qrate_control="--abr --he";;


esac

set -- "$qrate_control";


### EXECUTING COMMAND

declare input;

declare output;

input=$(handle_input "$usr_input");

for i in "$input";

do output=$(handle_output "$i");

FFREPORT=file="$output$FF_LOG_SUFFIX":level=32 ffmpeg $FF_SCAN -i "$i" $ff_stream_com $ff_audio_com $WAV_COM |\

qaac $QCONFIG $qrate_control $usr_bitrate - -o "$output.$usr_output_extension" 2>&1 |\

tee "$output$QLOG_SUFFIX";

done;

}
