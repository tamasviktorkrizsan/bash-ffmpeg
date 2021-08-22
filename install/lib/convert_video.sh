#!/bin/bash
# part of bash-ffmpeg Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later

function convert_video () {


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

declare usr_preset="${8:-crf}";

declare usr_codec="${9:-x264}";

declare usr_bitrate="${10:-18}";

declare usr_tune="${11:-auto}";


###INCLUDES

source ffmpeg.sh

source ffstream.sh

source ffvideo.sh


### CONSTANT SETTINGS

declare map="0";

declare TMP_FOLDER="TMP-VIDEO";


### PROCESSING

declare output ffstream_com ffvideo_com pass;

output=$(handle_output "$usr_input");

ffstream_com=$(concat_ffstream_string "$map" "$usr_split_start" "$usr_split_to");

ffvideo_com=$(concat_ffvideo_string "$usr_screen_mode" \
"$usr_width" "$usr_height" "$usr_fps" "$usr_preset" "$usr_codec" "$usr_bitrate" "$usr_tune");

pass="$ffstream_com $ffvideo_com";

log_suffix="convert_x264_$usr_preset.log";


# Convert )


case "$usr_preset" in

 "crf" | "fast" )

     ffmpeg $ff_scan -i "$usr_input" $pass "$output.264";; # 2>&1 |\
     #tee "$output_$log_suffix";

"pass12" )

    tmp_path=$(handle_output "$usr_input" "TMP-VIDEO");

    ffmpeg $ff_scan -i "$usr_input" $pass -pass 1 -passlogfile "$tmp_path" "$tmp_path" && output_path=$(handle_output "$usr_input" "TMP-VIDEO");

    ffmpeg $ff_scan -i "$usr_input" $pass -pass 2 -passlogfile "$tmp_path" "$output_path.264";;

  *)

    echo "ERROR! check the fps parameter!";;

esac

}
