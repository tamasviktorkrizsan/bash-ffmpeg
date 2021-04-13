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

local timecode=$1;

local timecode_ms;

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

local duration=$1;

local tc_duration;

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

local splitDurationMs=$1;


# get hour

local duration_hour;

duration_hour=$(($splitDurationMs / 3600000));

local remainder_hour;

remainder_hour=$(($splitDurationMs % 3600000));


# get minute

local duration_minute;

duration_minute=$(($remainder_hour / 60000));

local remainder_minute;

remainder_minute=$(($remainder_hour % 60000));


# get second

local duration_second;

duration_second=$(($remainder_minute / 1000));

local remainder_second;

remainder_second=$(($remainder_minute % 1000));


# get decisecond

local duration_decisecond;

duration_decisecond=$(($remainder_second / 100));


# correct timeformat

local timecode_hour;

timecode_hour=$(time_format $duration_hour);


local timecode_hour;

timecode_minute=$(time_format $duration_minute);


local timecode_second;

timecode_second=$(time_format $duration_second);


local timecode_decisecond=$duration_decisecond;


# assemble timeformat

local split_duration="$timecode_hour:$timecode_minute:$timecode_second.$timecode_decisecond";


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

local tc_split_start=$1;

local tc_split_end=$2;


# convert timecode to miliseconds

local split_end_ms;

split_end_ms=$(timecode_to_ms "$tc_split_end");


local split_start_ms;

split_start_ms=$(timecode_to_ms "$tc_split_start");


# subtract the two milisesconds value

local split_duration_ms;

split_duration_ms=$(($split_end_ms-$split_start_ms));


# covert miliseconds to timecode

local tc_split_duration;

tc_split_duration=$(ms_to_timecode $split_duration_ms);


# return the final timecode value

echo $tc_split_duration;

}
