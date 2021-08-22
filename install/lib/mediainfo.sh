#!/bin/bash
# part of bash-ffmpeg Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### BINARIES

# jq binaries

PATH=/cygdrive/c/build_suite/local64/bin-global:$PATH;


### FUNCTIONS

get_mediainfo_data () {


### INPUT PARAMETERS

declare usr_input="${1}";

declare -i usr_map="${2:-0}";

declare usr_data_type="${3:-Format}";


### PROCESSING

declare -i map=$((usr_map + 1));

declare data;

data=$(mediainfo "$usr_input" --Output=JSON |\

jq --raw-output ".media.track[$map].$usr_data_type" |\

tr -d '\r');

echo $data;

}


## VIDEO

get_width () {


declare usr_input="${1}";

declare data;

data=$(get_mediainfo_data "$usr_input" "0" "Width");

echo $data;

}


get_height () {

declare usr_input="${1}";

declare data;

data=$(get_mediainfo_data "$usr_input" 0 "Height");

echo $data;

}


get_fps () {

declare usr_input="${1}";

declare fps;

fps=$(get_mediainfo_data "$usr_input" 0 "FrameRate");

declare -i data;


case $fps in

  24 | 25 | 30 | 60 )

    data=$fps;;


  23.976)

    data=23;;


  29.970)

    data=29;;


  59.940)

    data=59;;


  *)

    echo "ERROR! The given parameter is not a Standard Framerate format!";;

esac

set "$data";

echo $data;

}


get_cover_format () {

usr_input="$1";

declare output;

declare data;


data=$(get_mediainfo_data "$usr_input" 0 "Cover_Mime");

case "$data" in

  "image/jpeg" ) output="jpg";;

  	         * ) echo "ERROR";;

esac

set "$output";

echo "$output";

}


get_track_format () {

usr_input=$1;

usr_map=$2;

declare output;

declare data;

data=$(get_mediainfo_data "$usr_input" 0 "Format");

case "$data" in

   "AVC" ) output="264";;

   "AAC LC" | "AAC LC SBR" ) output="aac";;

   "AC-3" ) output="ac3";;

  * ) echo "ERROR";;

esac

set "$output";

echo "$output";

}
