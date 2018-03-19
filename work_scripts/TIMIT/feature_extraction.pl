####################
# Feature extraction
####################

$TIMIT_DIR = "/home/liyao/Data/assignment_materials/TIMIT";
$CONFIG_DIR = "$TIMIT_DIR/config";
$LIST_DIR = "$TIMIT_DIR/list";

print("System: Extracting training corpus features...\n");
system("HCopy -C $CONFIG_DIR/config_HCopy -S $LIST_DIR/list_HCopy_train.scp");
print("System: Extracting testing corpus features...\n");
system("HCopy -C $CONFIG_DIR/config_HCopy -S $LIST_DIR/list_HCopy_test.scp");
print("Extraction complete\n");
