##########################
# Testing process
##########################

$TIMIT_DIR = "/home/liyao/Data/assignment_materials/TIMIT";
$CONFIG_DIR = "$TIMIT_DIR/config";
$LIST_DIR = "$TIMIT_DIR/list";
$LAB_DIR = "$TIMIT_DIR/labels";
$LIB_DIR = "$TIMIT_DIR/lib";
$SPEC_DIR = "$TIMIT_DIR/spec";
$WAV_DIR = "$TIMIT_DIR/wav";
$HMM_DIR = "$TIMIT_DIR/hmms/hmm40";
$MACRO_FILE = "$HMM_DIR/macros";
$MODEL_FILE = "$HMM_DIR/models";
$RESULT_DIR = "$TIMIT_DIR/result";
    
#Viterbi decoding
system("HVite -H $HMM_DIR/macros -H $HMM_DIR/models -S $LIST_DIR/list_mfcc_test.scp -C $CONFIG_DIR/config_train -w $LIB_DIR/phone_net -i $RESULT_DIR/result.mlf -s 0 -p 0 $LIB_DIR/phone_dict $LIB_DIR/phone_list");
system("HResults -e \"???\" sp -I $LAB_DIR/test.mlf $LIB_DIR/phone_list $RESULT_DIR/result.mlf");
