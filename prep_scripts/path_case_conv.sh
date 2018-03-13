#!/bin/bash

set -e

if [ "$#" != 2 ]
then
    echo "Usage: ./path_case_conv.sh [dir] [u2l | l2u]"
    exit
fi

cd $1


if [ "$2" =  "u2l" ]
then
    case_ctr="[:upper:] [:lower:]"
elif [ "$2" =  "l2u" ]
then
    case_ctr="[:lower:] [:upper:]"
fi

for name in `ls`
do
    t_name=`echo $name | tr $case_ctr`
    if [ "$t_name" != "$name" ]
    then
	mv -fv $name $t_name
    fi
done
