#!/bin/bash
# part of bash-ffmpeg Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### INPUT PARAMETERS

## FFMPEG General Parameters

input="test 1.mkv";

split_start="00:00:00.0";

split_to="09:00:00.0";


## FFMPEG Video Processing Parameters

screen_mode="scale";

width="640";

height="360";

fps="23";


### X264 Codec Paramters

preset="crf";

bitrate="18";

tune="film";


### INCLUDES

source convert_x264.sh


### EXECUTE

convert_x264 "$input" "$split_start" "$split_to" "$screen_mode" \
"$width" "$height" "$fps" "$preset" "$bitrate" "$tune";

next_script "" "";
