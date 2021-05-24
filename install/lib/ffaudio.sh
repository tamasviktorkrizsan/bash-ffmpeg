#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### CONSTANT SETTINGS

declare -xr DEFAULT_INPUT="*.wav *.flac *.m4a *.mp3 *.ac3 *.webm *.mp4 *.mkv *.mov *.wmv *.mpeg *.mpg *.flv *.avi *.divx *.vob *.bik";


### FUNCTIONS

#########################################################################
# Concat ffmpeg audio command string.
# Arguments:
#   Number of audio channels, sample rate (shorthand)
# Returns:
#   Concatenated ffmpeg audio command string
#########################################################################
concat_ffaudio () {


### INPUT PARAMETERS

declare usr_audio_channels=${1:-2};

declare usr_sample_rate=${2:-48};


### CONSTANTS

declare -r FF_RESAMPLER="-af aresample=resampler=soxr";


### PROCESSING

declare sample_rate;

case $usr_sample_rate in

   "44")

   sample_rate="44100";;


   "48")

   sample_rate="48000";;


   *)

   echo "ERROR! Check the rate control parameter!";;

esac

set -- "$sample_rate";


declare audio="-ac $usr_audio_channels -ar $sample_rate $FF_RESAMPLER";

echo "$audio";

}
