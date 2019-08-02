#!/bin/bash

export CUDA_VISIBLE_DEVICES=0,1,2,3

BASE=$HOME/project # change this as necessary

PROBLEM=mimic_discharge_summaries
MODEL=transformer
HPARAMS=transformer_base
DATA_DIR=$BASE/data/t2t_experiments/full_context/data
TRAIN_DIR=$BASE/data/t2t_experiments/full_context/output
USR_DIR=$BASE/t2t

t2t-trainer \
    --data_dir=$DATA_DIR \
    --problem=$PROBLEM \
    --model=$MODEL \
    --hparams_set=$HPARAMS \
    --hparams="max_length=10000,max_target_seq_length=512,max_input_seq_length=512" \
    --output_dir=$TRAIN_DIR \
    --t2t_usr_dir=$USR_DIR \
    --eval_steps=100 \
    --local_eval_frequency=250 \
    --train_steps=5000 \
    --worker_gpu=4