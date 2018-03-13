#!/bin/bash
##################################
# This script extracts subdirectories
# For example a possible directory structure:
#     d_0/d_00/d_000
#        /d_01/d_010
#             /d_011
#             /d_012
#             /f_013
#        /d_02/d_020
#             /d_021
#             /f_023
#             /f_024
#        /f_03
#        /f_04
#
# "d" indicates directories, "f" indicates files
# 
# After running,
# "./extract_from_subdir.sh ./d_0"
# The directory will look like:
#     d_0/d_00_d_000
#        /d_01_d_010
#        /d_01_d_011
#        /d_01_d_012
#        /d_01_f_013
#        /d_02_d_020
#        /d_02_d_021
#        /d_02_f_023
#        /d_02_f_024
#        /f_03
#        /f_04
#
# In short, Eliminates second layer of directory.
##################################

set -e

if [ "$#" != 1 ]
then
    echo "Usage: ./extract_from_subdir.sh [dir]"
    exit
fi

cd $1

subdir_list=$(find . -mindepth 1 -maxdepth 1 -type d)

for subdir in $subdir_list
do
    #remove proceeding "./"
    subdir=${subdir:2}
    cd $subdir
    echo "Entering $subdir..."
    content_list=$(ls)
    for content in $content_list
    do
	mv -f $content ../${subdir}_${content}
    done
    cd ..
    rm -frv $subdir
done
