#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### INPUT PARAMETERS

## FFMPEG General Parameters

input="";

map="0";

split_start="00:00:00.0";

split_to="09:00:00.0";


## FFMPEG Audio Processing

audio_channels="2";

sample_rate="44";


### QAAC Codec

rate_control="abr";

bitrate="127";

output_extension="m4a";


### INCLUDES

source convert_qaac.sh


### EXECUTE SCRIPT

convert_qaac "$input" $map $split_start $split_to $audio_channels $sample_rate $rate_control $bitrate $output_extension;

next_script "" "";
