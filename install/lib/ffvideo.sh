#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### INCLUDES

source x264.sh


### CONSTANT SETTINGS

declare -xr DEFAULT_INPUT="*.mkv *.264";


### FUNCTIONS

#########################################################################
# Concat ffmpeg video command string.
# Arguments:
#   Track number, number of audio channels, sample rate (shorthand)
# Returns:
#   Concatenated ffmpeg video command string
#########################################################################
function concat_ffvideo_string () {


### INPUT PARAMETERS

### INPUT PARAMETERS


## FFMPEG Input Video Processing Parameters (1, 5-8)

declare usr_screen_mode="${1}";


## FFMPEG Shared Parameters (1, 5-8)

declare usr_width="${2}";

declare usr_height="${3}";

declare usr_fps="${4}";

declare usr_preset="${5}";


### OUTPUT PARAMETERS

declare usr_codec="${6}";

declare usr_bitrate="${7}";

# Codec Parameters

declare usr_tune="${8}";


### INCLUDES

source x264.sh


### CONSTANT SETTINGS

declare -r SHARED_COM="-an";


### PROCESSING

## Step 1 - Set Resolution

declare res_com="-vf $usr_screen_mode=$usr_width:$usr_height";


## Step 2 - Set Framerate & Keyframe

declare fps;

declare -i key_min;


case "$usr_fps" in

	  23 | 23.976)
        fps="24000/1001"; key_min=24;;

    "24")
        fps="24/1"; key_min=24;;

    "25")
        fps="25/1"; key_min=25;;

    "29")
        fps="30000/1001"; key_min=30;;

    "30")
        fps="30/1"; key_min=30;;

    "59")
        fps="60000/1001"; key_min=60;;

    "60")
        fps="60/1"; key_min=60;;

	   *)
		    echo "ERROR! check the fps parameter x!";;

esac

set "$fps";
set "$key_min";


# set max framerate

declare -i key_max;

key_max=$((key_min * 10));

declare frame_com="-force_fps -r $fps -keyint_min $key_min -g $key_max";


## Step 3 - Set Rate Control

declare bitrate_com="-crf $usr_bitrate";


## Step # - select codec

case $usr_codec in

  "x264")

  codec_com=$(concat_x264_string $usr_width $usr_height $usr_fps $usr_preset $usr_tune);;


  *)

	echo "ERROR! Check the Codec parameter";;

esac


### RETURN

declare com="$SHARED_COM $res_com $frame_com $bitrate_com $codec_com";

echo "$com";

}
