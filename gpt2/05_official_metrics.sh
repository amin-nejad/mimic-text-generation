#!/bin/bash

BASE=$HOME/project/text-generation # change this as necessary
PREPROC=$BASE/data/preprocessed/low_resource
TRAIN_DIR=$BASE/data/gpt2/low_resource

mkdir $PREPROC/gold
ln -s $PREPROC/tgt-test.txt $PREPROC/gold/tgt-test.A.001.txt
GOLD=$PREPROC/gold/tgt-test.A.001.txt

mkdir $TRAIN_DIR/gpt2_decoded
ln -s $TRAIN_DIR/test-output-text.txt $TRAIN_DIR/gpt2_decoded/tgt-test.001.txt
PREDICTION=$TRAIN_DIR/gpt2_decoded/tgt-test.001.txt

wc -l $PREDICTION
wc -l $GOLD

# Evaluate the official ROUGE score
# Note: Report this ROUGE score in papers, not the internal approx_rouge metric.

pyrouge_evaluate_plain_text_files -s $TRAIN_DIR/gpt2_decoded/ -sfp "tgt-test.(\d+).txt" -m $PREPROC/gold/ -mfp tgt-test.[A-Z].#ID#.txt > $TRAIN_DIR/gpt2_decoded/rouge.txt

# Evaluate the official BLEU score
# Note: Report this BLEU score in papers, not the internal approx_bleu metric.

t2t-bleu --translation=$PREDICTION --reference=$GOLD > $TRAIN_DIR/gpt2_decoded/bleu.txt
