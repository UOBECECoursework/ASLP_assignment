#!/bin/bash
set -e

if [ "$#" != 2 ]
then
    echo "Usage: ./extract_spkr.sh [old corpus dir] [new corpus dir]"
    exit
fi

OLD_PATH=`cd $1; pwd`
NEW_PATH=`cd $2; pwd`

mkdir -p ${NEW_PATH}/labels
mkdir -p ${NEW_PATH}/wav

NEW_LAB_PATH=${NEW_PATH}/labels
NEW_WAV_PATH=${NEW_PATH}/wav


cd $OLD_PATH

for spkr_dir in `ls`
do
    cd $spkr_dir

    #copy wav files
    cd wav_*
    for wav_file in `ls`
    do
	cp -fv $wav_file $NEW_WAV_PATH/${spkr_dir}_${wav_file}
    done
    cd ..

    #copy wrd files
    cd wrd
    for wrd_file in `ls`
    do
	cp -fv $wrd_file $NEW_LAB_PATH/${spkr_dir}_${wrd_file}
    done
    cd ..
    
    #copy lab files
    cd lab
    for lab_file in `ls`
    do
	cp -fv $lab_file $NEW_LAB_PATH/${spkr_dir}_${lab_file}
    done
    cd ..
    
    cd ..
done


