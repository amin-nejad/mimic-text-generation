#!/bin/bash

BASE=$HOME/project/text-generation # change this as necessary
PREPROC=$BASE/data/preprocessed
TRAIN_DIR=$BASE/data/t2t_experiments/full_context/output

rm $PREPROC/temp_*
cat $TRAIN_DIR/tgt-decoded-0.txt $TRAIN_DIR/tgt-decoded-1.txt $TRAIN_DIR/tgt-decoded-2.txt $TRAIN_DIR/tgt-decoded-3.txt > $TRAIN_DIR/transformer-decoded.txt
rm $TRAIN_DIR/tgt-decoded*

wc -l $TRAIN_DIR/transformer-decoded.txt
sed -i '/^$/d' $TRAIN_DIR/transformer-decoded.txt
wc -l $TRAIN_DIR/transformer-decoded.txt

# Evaluate the BLEU score
# Note: Report this BLEU score in papers, not the internal approx_bleu metric.

head -8 $PREPROC/tgt-test.txt > $PREPROC/tgt-test-8.txt
wc -l $PREPROC/tgt-test-8.txt

t2t-bleu --translation=$TRAIN_DIR/transformer-decoded.txt --reference=$PREPROC/tgt-test-8.txt