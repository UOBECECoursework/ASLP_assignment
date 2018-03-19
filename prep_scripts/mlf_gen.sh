#!/bin/bash

set -e

if [ "$#" != 1 ]
then
    echo "Usage: ./mlf_gen.sh [dir] > [main label file name]"
    exit
fi

cd $1

echo "#!MLF!#"

for lab_file in `ls | grep "\.lab"`
do
    echo "\"*/${lab_file}\""
    cat $lab_file
    echo "."
done
