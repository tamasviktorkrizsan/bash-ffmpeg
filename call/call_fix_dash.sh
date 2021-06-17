#!/bin/bash
# part of Bash-presets Copyright (C) 2021 Tamas Viktor Krizsan
# <https://github.com/tamasviktorkrizsan>
# License: GPL-3.0-or-later


### INPUT PARAMETERS

input="";

split_start="00:00:00.0";

split_to="09:00:00.0";


### INCLUDES

source fix_dash.sh


### EXECUTE SCRIPT

fix_dash "$input" $split_start $split_to;

next_script "" "";
