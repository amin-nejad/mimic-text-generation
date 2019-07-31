#!/bin/bash

export CUDA_VISIBLE_DEVICES=

BASE=$HOME/project # change this as necessary

PROBLEM=mimic_discharge_summaries
MODEL=transformer
HPARAMS=transformer_base
DATA_DIR=$BASE/data/t2t_experiments/full_context/data
TRAIN_DIR=$BASE/data/t2t_experiments/full_context/output
USR_DIR=$BASE/t2t

DECODE_FILE=$BASE/data/preprocessed/src-test.txt

BEAM_SIZE=4
ALPHA=0.6

t2t-decoder \
    --t2t_usr_dir=$USR_DIR \
    --data_dir=$DATA_DIR \
    --problem=$PROBLEM \
    --model=$MODEL \
    --hparams_set=$HPARAMS \
    --hparams="batch_size=512,max_length=10000,max_target_seq_length=512,max_input_seq_length=512" \
    --output_dir=$TRAIN_DIR \
    --decode_hparams="beam_size=$BEAM_SIZE,alpha=$ALPHA" \
    --decode_from_file=$DECODE_FILE \
    --decode_to_file=transformer_decoded.txt

# Evaluate the BLEU score
# Note: Report this BLEU score in papers, not the internal approx_bleu metric.
#t2t-bleu --translation=transformer_decoded.txt --reference=$BASE/data/preprocessed/tgt-test.txt