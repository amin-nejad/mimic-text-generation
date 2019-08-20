#!/bin/bash

export CUDA_VISIBLE_DEVICES=0,1,2,3
BASE=$HOME/project # change this as necessary

PROBLEM=mimic_discharge_summaries
MODEL=transformer
HPARAMS=transformer_base
USR_DIR=$BASE/t2t

for i in {h,h-gae,h-gae-d,h-gae-p,h-gae-d-p,h-gae-d-p-m,h-gae-d-p-m-t,h-gae-d-p-m-l}
do
    export CUDA_VISIBLE_DEVICES=0,1,2,3
    DATA_DIR=$BASE/data/t2t_experiments/other_contexts/$i/data
    TRAIN_DIR=$BASE/data/t2t_experiments/other_contexts/$i/output

    t2t-trainer \
        --data_dir=$DATA_DIR \
        --problem=$PROBLEM \
        --model=$MODEL \
        --hparams_set=$HPARAMS \
        --hparams="max_length=10000,max_target_seq_length=512,max_input_seq_length=512" \
        --output_dir=$TRAIN_DIR \
        --t2t_usr_dir=$USR_DIR \
        --train_steps=5000 \
        --eval_steps=50 \
        --worker_gpu=4
#        --warm_start_from=$TRAIN_DIR
done