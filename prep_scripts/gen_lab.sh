#!/bin/bash

set -e

if [ "$#" != 3 ]
then
    echo "Usage: $0 [word_dict] [src_dir] [dest_dir]"
    exit
fi

declare -S word_phone_map

while IFS= read -r map_line
do
    map_ele=`echo "map_line" | tr " " "\t" "\n"`
    word_phone_map[map_ele[0]]="fuck";
done < word_dict



# cd $2

# for wrd_file in `ls *.wrd`
# do
    
# done
