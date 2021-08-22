#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### FUNCTIONS

#########################################################################
# Concat ffmpeg x264 command string.
# Arguments:
#   Track number, number of audio channels, sample rate (shorthand)
# Returns:
#   Concatenated ffmpeg audio command string
#########################################################################
function concat_x264_string () {


### INPUT PARAMETERS

# shared param

declare -i usr_width=${1};

declare -i usr_height=${2};

declare -i usr_fps=${3};


# x264 param

declare usr_preset="${4}";

declare usr_tune="${5}";


### CONSTANTS

declare -r SHARED_COM="-codec:v libx264 -strict -2 -f h264 -pix_fmt yuv420p";


### PROCESSING

## Step 1 - Set Video Level

declare level;


if ((0 < usr_width && usr_width <= 640)) && ((0 < usr_fps && usr_fps <= 60));
  then level="3.0";

  elif ((640 < usr_width)) && ((0 < usr_fps && usr_fps <= 60));
    then level="4.2";

  else echo "ERROR! Check the widght,height or fps parameter!";

fi


## Step 2 - Set Profile

declare maxrate bufsize;

declare profile="high";

declare device="";


case $level in

	  "3.0")
        maxrate="10000k"; bufsize="10000k"; profile="main"; device="-x264opts ref=3:b-pyramid=none:weightp=1";;

    "4.2")
        maxrate="9000k"; bufsize="9000k";;

	   *)
		    echo "ERROR! check the resolution parameter!";;

esac

set -- "$maxrate";
set -- "$bufsize";
set -- "$profile";
set -- "$device";


### Step 2,5 - Set Rate Control

declare process_speed;

case $usr_preset in

	  "fast")
        process_speed="medium"; profile="main"; device="-x264opts ref=3:b-pyramid=none:weightp=1";;

    "crf" | "pass12" | "pass1" | "pass2")
        process_speed="veryslow";;

	   *)
		    echo "ERROR! check the preset parameter!";;

esac

set -- "$process_speed";
set -- "$profile";
set -- "$device";

vlevel_com="-profile:v $profile -level $level -maxrate $maxrate -bufsize $bufsize $device";


### Step 4 - Set Tune

if [[ "$usr_tune" == "auto" ]]; then tune="";

  else tune="-tune $usr_tune";

fi

### RETURN

x264_com="$SHARED_COM $vlevel_com -preset $process_speed $tune";

echo "$x264_com";

}
