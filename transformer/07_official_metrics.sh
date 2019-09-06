#!/bin/bash

BASE=$HOME/project/text-generation # change this as necessary
PREPROC=$BASE/data/preprocessed/low_resource
TRAIN_DIR=$BASE/data/t2t_experiments/transformer/low_resource/full_context/output

mkdir $PREPROC/gold
ln -s $PREPROC/tgt-test.txt $PREPROC/gold/tgt-test.A.001.txt
GOLD=$PREPROC/gold/tgt-test.A.001.txt
mkdir $TRAIN_DIR/transformer_decoded
PREDICTION=$TRAIN_DIR/transformer_decoded/tgt-test.001.txt

rm $PREPROC/temp_*
cat $TRAIN_DIR/tgt-decoded-0.txt $TRAIN_DIR/tgt-decoded-1.txt $TRAIN_DIR/tgt-decoded-2.txt $TRAIN_DIR/tgt-decoded-3.txt > $PREDICTION
#rm $TRAIN_DIR/tgt-decoded*

# Remove blank lines

wc -l $PREDICTION
sed -i '/^$/d' $PREDICTION
wc -l $PREDICTION
wc -l $GOLD

# Evaluate the official ROUGE score
# Note: Report this ROUGE score in papers, not the internal approx_rouge metric.

pyrouge_evaluate_plain_text_files -s $TRAIN_DIR/transformer_decoded/ -sfp "tgt-test.(\d+).txt" -m $PREPROC/gold/ -mfp tgt-test.[A-Z].#ID#.txt > $TRAIN_DIR/transformer_decoded/rouge.txt

# Evaluate the official BLEU score
# Note: Report this BLEU score in papers, not the internal approx_bleu metric.

t2t-bleu --translation=$PREDICTION --reference=$GOLD > $TRAIN_DIR/transformer_decoded/bleu.txt
