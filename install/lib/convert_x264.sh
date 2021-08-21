#!/bin/bash
# part of bash-ffmpeg Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later

### FUNCTION

#############################################################
# Convert input video to .264 file (x264 codec)
# placed in the "OUTPUT" folder.
# Arguments:
#   input file, track number, start timecode, end timecode,
#   screen mode, resolution width,resolution height, fps,
#   tune, preset, bitrate
#############################################################
function convert_x264 () {


### INPUT PARAMETERS


## FFMPEG Shared Parameters (2-4)

declare usr_input="${1:-auto}";


## FFMPEG Input Stream Parameters (2-4)

declare usr_split_start="${2}";

declare usr_split_to="${3}";


## FFMPEG Input Video Processing Parameters (1, 5-8)

declare usr_screen_mode="${4}";

declare usr_width="${5}";

declare usr_height="${6}";

declare usr_fps="${7}";


### OUTPUT PARAMETERS

## X264 Codec Output Paramters

declare usr_preset="${8}";

declare usr_bitrate="${9}";

declare usr_tune="${10}";


### INCLUDES

source bash.inc.sh

source get_video_specs.sh


### CONSTANT

declare -r USR_CODEC="x264";


### EXECUTE COMMAND

case $usr_input in

   "auto")

     # DEFAULT ALL FORMATS (CRF)

      for i in $DEFAULT_INPUT;
      do get_video_specs "$i" "$usr_split_start" "$usr_split_to" \
      "$usr_screen_mode" "$usr_width" "$usr_height" "$usr_fps" \
      "$usr_preset" "$USR_CODEC" "$usr_bitrate" "$usr_tune";
      done;;


   *.csv)

    # READ INPUT FROM A CSV FILE

    while read -r line
    do i="$(echo "$line" | awk -F',' '{printf "%s", $1}')";
    usr_split_start=$(echo "$line" | awk -F',' '{printf "%s", $2}');
    usr_split_end=$(echo "$line" | awk -F',' '{printf "%s", $3}');

    get_video_specs "$i" "$usr_split_start" "$usr_split_to" \
    "$usr_screen_mode" "$usr_width" "$usr_height" "$usr_fps" \
    "$usr_preset" "$USR_CODEC" "$usr_bitrate" "$usr_tune";

    done < "$usr_input";;



  # SOLO FORMAT (CRF,PASS1,PASS2,PASS12)

   *)

      for i in "$usr_input";
      do get_video_specs "$i" "$usr_split_start" "$usr_split_to" \
      "$usr_screen_mode" "$usr_width" "$usr_height" "$usr_fps" \
      "$usr_preset" "$USR_CODEC" "$usr_bitrate" "$usr_tune";
      done;;

esac


}
