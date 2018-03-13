#!/bin/bash

set -e

if [ "$#" != 1 ]
then
    echo "Usage: ./mlf_gen.sh [dir] > [main label file name]"
    exit
fi

cd $1

echo "#!MLF!#"

lab_file_list=$(ls | grep "\.lab")
for lab_file in $lab_file_list
do
    echo "\"*/${lab_file}\""
    cat $lab_file
    echo "."
done
