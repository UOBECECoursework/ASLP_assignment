#######################
# Training prpcess
#######################

$TIMIT_DIR = "/home/liyao/Data/assignment_materials/TIMIT";
$CONFIG_DIR = "$TIMIT_DIR/config";
$LIST_DIR = "$TIMIT_DIR/list";
$LAB_DIR = "$TIMIT_DIR/labels";
$LIB_DIR = "$TIMIT_DIR/lib";
$SPEC_DIR = "$TIMIT_DIR/spec";
$WAV_DIR = "$TIMIT_DIR/wav";
$HMM_DIR = "$TIMIT_DIR/hmms";

system("rm -fr $HMM_DIR/*");

#Flat start
print("Flat start, estimating parameters...\n");
mkdir("$HMM_DIR/hmm0");
system("HCompV -C $CONFIG_DIR/config_train -o hmmdef -f 0.01 -m -S $LIST_DIR/list_mfcc_train.scp -M $HMM_DIR/hmm0 $LIB_DIR/proto_s1d39_st8m1");


print("Flat start completed!\n");

#Generate seed HMM
print("Generating seed HMM...\n");
system("MACRO 39 MFCC_E_D_A $HMM_DIR/hmm0/vFloors $HMM_DIR/hmm0/macros");
system("MODELS_1MIXSIL $TIMIT_DIR/lib/phone_list $HMM_DIR/hmm0/hmmdef $HMM_DIR/hmm0/models");
print("Seed HMM generated!\n");

#Training
print("Training...\n");


foreach $mix_num (1..8)
{
    #4 iterations after every inserted mixture component
    $iter_end = $mix_num * 5 - 1;
    $iter_beg = $iter_end - 3;
    $prev_iter_end = $iter_beg - 1;
    mkdir("$HMM_DIR/hmm${iter_beg}");
    system("HHEd -H $HMM_DIR/hmm${prev_iter_end}/macros -H $HMM_DIR/hmm${prev_iter_end}/models -M $HMM_DIR/hmm${iter_beg} $LIB_DIR/mix${mix_num}_st3.hed $LIB_DIR/phone_list");
    print("${prev_iter_end}->${iter_beg}, $mix_num mixture generated!\n");
    
    foreach $iter ($iter_beg..$iter_end)
    {
	$next_iter = $iter + 1;
	mkdir("$HMM_DIR/hmm${next_iter}");
	system("HERest -C $CONFIG_DIR/config_train -I $LAB_DIR/train.mlf -S $LIST_DIR/list_mfcc_train.scp -H $HMM_DIR/hmm${iter}/macros -H $HMM_DIR/hmm${iter}/models -M $HMM_DIR/hmm${next_iter} $LIB_DIR/phone_list");
	print("${iter}->${next_iter} iteration completed!\n");
    }
}
print("Training completed!\n");
