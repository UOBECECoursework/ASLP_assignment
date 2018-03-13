#!/bin/bash

set -e

if [ "$#" != 2 ]
then
    echo "Usage: ./gen_hed.sh [phone filename] [mixture number] > [hed file]"
    exit
fi

while IFS= read -r phone
do
    echo "MU $2 {${phone}.state[2-4].mix}"
done < $1
