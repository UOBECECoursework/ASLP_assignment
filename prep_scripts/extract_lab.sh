#!/bin/bash

TIMIT_DIR="/home/liyao/Data/assignment_materials/TIMIT"
LAB_DIR="$TIMIT_DIR/labels"
LAB_TRAIN_DIR="$LAB_DIR/train"
LAB_TEST_DIR="$LAB_DIR/test"

mkdir -p $LAB_DIR/train_labs

#Copy all .lab files to a unified directory and change their names to prevent duplication
cd $LAB_TRAIN_DIR
ls */*  | grep -E "\.lab" > $TIMIT_DIR/lab_log
while IFS= read -r lab_path
do
    lab_newname=`echo $lab_path | sed -E -e "s/\//_/g"`
    #echo $lab_newname
    cp -f $lab_path $LAB_DIR/train_labs/$lab_newname
done < $TIMIT_DIR/lab_log

rm -fv $TIMIT_DIR/lab_log
