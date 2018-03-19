#!/bin/bash

set -e

CORP_DIR="/home/liyao/Data/assignment_materials/CORP2018"
WAV_DIR="$CORP_DIR/wav"
WAV_TRAIN_DIR="$WAV_DIR/train"
WAV_TEST_DIR="$WAV_DIR/test"
LIST_DIR="$CORP_DIR/list"

#make $LIST_DIR if not exist
mkdir -p $LIST_DIR
#Clear $LIST_DIR 
rm -f $LIST_DIR/list_mfcc_train.scp $LIST_DIR/list_mfcc_test.scp $LIST_DIR/list_HCopy_train.scp $LIST_DIR/list_HCopy_test.scp

#generate mfcc list and HCopy list for training subset
cd $WAV_TRAIN_DIR
for wav_file in `ls`
do
    wav_file=`readlink -f $wav_file`
    mfcc_file=`echo $wav_file | sed -E -e "s/\.wav/\.mfcc/g" -e s/wav/spec/g`
    echo "${wav_file} ${mfcc_file}" >> $LIST_DIR/list_HCopy_train.scp
    echo "${mfcc_file}" >> $LIST_DIR/list_mfcc_train.scp
done

cd $WAV_TEST_DIR
for wav_file in `ls`
do
    wav_file=`readlink -f $wav_file`
    mfcc_file=`echo $wav_file | sed -E -e "s/\.wav/\.mfcc/g" -e s/wav/spec/g`
    echo "${wav_file} ${mfcc_file}" >> $LIST_DIR/list_HCopy_test.scp
    echo "${mfcc_file}" >> $LIST_DIR/list_mfcc_test.scp
done
