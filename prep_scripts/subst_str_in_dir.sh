#!/bin/bash

set -e

if [ "$#" != 4 ]
then
    echo "Usage: $0 [dir] [filename] [re_src] [re_dst]"
    exit
fi

cd $1

for f in `ls $2`
do
    sed -i -E "s/$3/$4/g" $f
done

    
