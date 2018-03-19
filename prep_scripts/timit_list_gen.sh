#!/bin/bash
#############################
# This bash script is for generating HCopy feature extraction sript, which will later be used as HCopy -S parameter
# Usage: 
#############################

set -e

TIMIT_DIR="/home/liyao/Data/assignment_materials/TIMIT"
WAV_DIR="$TIMIT_DIR/wav"
WAV_TRAIN_DIR="$WAV_DIR/train"
WAV_TEST_DIR="$WAV_DIR/test"

SPEC_DIR="$TIMIT_DIR/spec"
SPEC_TRAIN_DIR="$SPEC_DIR/train"
SPEC_TEST_DIR="$SPEC_DIR/test"

LIST_DIR="$TIMIT_DIR/list"

#make $LIST_DIR if not exist
mkdir -p $LIST_DIR
#Clear $LIST_DIR 
rm -f $LIST_DIR/*

#Copy wav/train subdirectory structure
mkdir -p $SPEC_TRAIN_DIR
cd $WAV_TRAIN_DIR
find . -type d > $TIMIT_DIR/dir_struct
cd $SPEC_TRAIN_DIR
xargs mkdir -p < $TIMIT_DIR/dir_struct

#Copy wav/test subdirectory structure
mkdir -p $SPEC_TEST_DIR
cd $WAV_TEST_DIR
find . -type d > $TIMIT_DIR/dir_struct
cd $SPEC_TEST_DIR
xargs mkdir -p < $TIMIT_DIR/dir_struct

rm -f $TIMIT_DIR/dir_struct

#Generate full paths of wav files
find $WAV_TRAIN_DIR -mindepth 1 -type f | xargs -I {} readlink -f {} > $LIST_DIR/list_HCopy_train.scp
find $WAV_TEST_DIR -mindepth 1 -type f | xargs -I {} readlink -f {} > $LIST_DIR/list_HCopy_test.scp

#Append corresponding spec file names after wav file names
while IFS= read -r wav_path
do
    mfcc_path=`echo $wav_path | sed -E -e "s/\.wav/\.mfcc/g" -e "s/wav/spec/g"`
    wav_mfcc_path="$wav_path $mfcc_path"
    echo $mfcc_path >> $LIST_DIR/list_mfcc_train.scp
    echo $wav_mfcc_path >> $LIST_DIR/list_HCopy_train.tmp
done < $LIST_DIR/list_HCopy_train.scp
mv -f $LIST_DIR/list_HCopy_train.tmp $LIST_DIR/list_HCopy_train.scp

while IFS= read -r wav_path
do
    mfcc_path=`echo $wav_path | sed -E -e "s/\.wav/\.mfcc/g" -e "s/wav/spec/g"`
    wav_mfcc_path="$wav_path $mfcc_path"
    echo $mfcc_path >> $LIST_DIR/list_mfcc_test.scp
    echo $wav_mfcc_path >> $LIST_DIR/list_HCopy_test.tmp
done < $LIST_DIR/list_HCopy_test.scp
mv -f $LIST_DIR/list_HCopy_test.tmp $LIST_DIR/list_HCopy_test.scp
