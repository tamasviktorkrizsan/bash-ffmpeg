#!/bin/bash
# part of bash-ffmpeg-functions Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### INCLUDES

source bash.inc.sh


### CONSTANTS

PATH=/cygdrive/c/build_suite/local64/bin-global:$PATH;


### FUNCTIONS

scan_mediainfo () {

## Input Parameters

usr_input=${1:-*.webm *.mp4 *.mkv *.mov *.wmv *.mpeg *.mpg *.flv *.avi *.divx *.vob *.264 *.h264 *.wav *.flac *.m4a *.mp3};


### Settings

media_log_suffix="_scan_mediainfo.log";


### Executing Command

for i in $usr_input;
do mediainfo "$i" --Output=JSON 2>&1 |\
tee "${i%}_$media_log_suffix";
done;

}
