#!/bin/bash

export CUDA_VISIBLE_DEVICES=0,1,2,3

BASE=$HOME/project/text-generation # change this as necessary

PROBLEM=mimic_discharge_summaries
MODEL=transformer_moe
HPARAMS=transformer_moe_base
DATA_DIR=$BASE/data/t2t_experiments/transformer_moe/full_context/data
TRAIN_DIR=$BASE/data/t2t_experiments/transformer_moe/full_context/output
USR_DIR=$BASE/transformer_moe

t2t-trainer \
    --t2t_usr_dir=$USR_DIR \
    --problem=$PROBLEM \
    --model=$MODEL \
    --hparams_set=$HPARAMS \
    --data_dir=$DATA_DIR \
    --output_dir=$TRAIN_DIR \
    --eval_use_test_set=True \
    --eval_steps=1000 \
    --schedule=evaluate \
    --worker_gpu=4
