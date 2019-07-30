#!/bin/bash

export CUDA_VISIBLE_DEVICES=0,1,2,3

BASE=$HOME/project # change this as necessary

PROBLEM=mimic_discharge_summaries
MODEL=transformer
HPARAMS=transformer_base
DATA_DIR=$BASE/data/t2t/data
TRAIN_DIR=$BASE/data/t2t/output
USR_DIR=$BASE/t2t

~/anaconda3/envs/tf/bin/t2t-trainer \
    --data_dir=$DATA_DIR \
    --problem=$PROBLEM \
    --model=$MODEL \
    --hparams_set=$HPARAMS \
    --hparams="max_length=10000,max_target_seq_length=512,max_input_seq_length=512" \
    --output_dir=$TRAIN_DIR \
    --t2t_usr_dir=$USR_DIR \
    --train_steps=400000 \
    --eval_steps=1000
