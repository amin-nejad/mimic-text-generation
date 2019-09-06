#!/bin/bash

export CUDA_VISIBLE_DEVICES=0,1,2,3

BASE=$HOME/project/text-generation # change this as necessary

# transformer
MODEL=transformer
HPARAMS=transformer_base
HPARAMS_OVERRIDE="max_length=10000,max_target_seq_length=512,max_input_seq_length=512"

PROBLEM=mimic_discharge_summaries
DATA_DIR=$BASE/data/t2t_experiments/$MODEL/low_resource/full_context/data
TRAIN_DIR=$BASE/data/t2t_experiments/$MODEL/low_resource/full_context/output
USR_DIR=$BASE/transformer

t2t-trainer \
    --data_dir=$DATA_DIR \
    --problem=$PROBLEM \
    --model=$MODEL \
    --hparams_set=$HPARAMS \
    --hparams=$HPARAMS_OVERRIDE \
    --output_dir=$TRAIN_DIR \
    --t2t_usr_dir=$USR_DIR \
    --eval_steps=50 \
    --local_eval_frequency=200 \
    --train_steps=4000 \
    --worker_gpu=4 \
    --warm_start_from=$TRAIN_DIR
