#!/bin/bash
# part of Bash-presets Copyright (C) 2020 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later
#
# this file contains all the necessary functions to subtract two timecodes to
# get a "duration timecode" for use in FFMPEG.


#####################################################
# Convert timecode to milliseconds.
# Arguments:
#   Timecode
# Outputs:
#   Writes a calculated milliseconds value to stdout
#####################################################
function timecode_to_ms () {

declare timecode=$1;

declare -i timecode_ms;

timecode_ms=$(echo "$timecode" | awk -F: '{ print ($1 * 3600000) + ($2 * 60000) + ($3 * 1000) + ($4*100) }');

echo "$timecode_ms";

}


###########################################################
# Correct timecode (e.g. 9 -> 09).
# Arguments:
#   (uncorrected) timecode duration
# Outputs:
#   Writes a timecode value to stdout in the proper format
###########################################################
function time_format () {

declare duration=$1;

declare tc_duration;

if [[ duration -le 9 ]]; then

    tc_duration=$(printf "%02d" $duration);

	else tc_duration=$duration;

fi

echo "$tc_duration";

}


#####################################################
# Convert milliseconds to timecode.
# Arguments:
#   Timecode
# Outputs:
#   Writes a calculated milliseconds value to stdout
#####################################################
function ms_to_timecode () {

# input parameters

declare -i splitDurationMs=$1;


# get hour

declare -i duration_hour=$(($splitDurationMs / 3600000));

declare -i remainder_hour=$(($splitDurationMs % 3600000));


# get minute

declare -i duration_minute=$(($remainder_hour / 60000));

declare -i remainder_minute=$(($remainder_hour % 60000));


# get second

declare -i duration_second=$(($remainder_minute / 1000));

declare -i remainder_second=$(($remainder_minute % 1000));


# get decisecond

declare -i duration_decisecond=$(($remainder_second / 100));


# correct timeformat

declare timecode_hour;

timecode_hour=$(time_format $duration_hour);


declare timecode_minute;

timecode_minute=$(time_format $duration_minute);


declare timecode_second

timecode_second=$(time_format $duration_second);


declare timecode_decisecond=$duration_decisecond;


# assemble timeformat

declare split_duration="$timecode_hour:$timecode_minute:$timecode_second.$timecode_decisecond";


# return the converted timecode value

echo "$split_duration";

}


########################################################
# Subtract timecode. This is the main function.
# Arguments:
#   Split start timecode, split end timecode
# Outputs:
#   Writes Split duration in timecode format to stdout
#######################################################
function subtract_timecode () {

# input parameters

declare tc_split_start=$1;

declare tc_split_end=$2;


# convert timecode to miliseconds

declare -i split_end_ms;

split_end_ms=$(timecode_to_ms "$tc_split_end");


declare -i split_start_ms;

split_start_ms=$(timecode_to_ms "$tc_split_start");


# subtract the two milisesconds value

declare -i split_duration_ms=$(( $split_end_ms - $split_start_ms ));


# covert miliseconds to timecode

declare tc_split_duration;

tc_split_duration=$(ms_to_timecode $split_duration_ms);


# return the final timecode value

echo $tc_split_duration;

}
