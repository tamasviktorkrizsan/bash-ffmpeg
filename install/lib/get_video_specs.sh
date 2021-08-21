#!/bin/bash
# part of Bash-presets Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later

### FUNCTION

#######################################################################
# Fill missing parameter data with values got from
# source file inspection (mediainfo) or with predefined default values.
# the results will be forwarded to the video processing function.
#
# Arguments:
#   input file, screen mode, resolution width,resolution height, fps,
#   codec, tune, preset, bitrate, tune
#######################################################################
function get_video_specs () {


  ### INPUT PARAMETERS

  ## FFMPEG Shared Parameters (2-4)

  declare usr_input="${1}";


  ## FFMPEG Input Stream Parameters (2-4)

  declare usr_split_start="${2:-00:00:00.0}";

  declare usr_split_to="${3:-09:00:00.0}";


  ## FFMPEG Input Video Processing Parameters (1, 5-8)

  declare usr_screen_mode="${4:-scale}";

  declare usr_width="${5:-auto}";

  declare usr_height="${6:-auto}";

  declare usr_fps="${7:-auto}";


  ### OUTPUT PARAMETERS

  ## X264 Codec Output Paramters

  declare usr_preset="${8:-fast}";

  declare usr_codec="${9:-x264}";

  declare usr_bitrate="${10:-23}";

  declare usr_tune="${11:-auto}";


### INCLUDES

source mediainfo.sh

source convert_video.sh


### INSPECT VIDEO SPECS

# Inspect width

declare width;

if [[ "$usr_width" == "auto"  ]]

  then width=$(get_width "$usr_input");

  else width=$usr_width;

fi

## Inspect height

declare height;

if [[ "$usr_height" == "auto"  ]]

  then height=$(get_height "$usr_input");

  else height=$usr_height;

fi


## Inspect fps

declare fps;

if [[ "$usr_fps" == "auto"  ]]

  then fps=$(get_fps "$usr_input");

  else fps=$usr_fps;

fi


### EXECUTE COMMAND

convert_video "$usr_input" "$usr_split_start" "$usr_split_to" \
"$usr_screen_mode" "$width" "$height" "$fps" \
"$usr_preset" "$usr_codec" "$usr_bitrate" "$usr_tune";

  }
