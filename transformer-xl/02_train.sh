#!/bin/bash

export CUDA_VISIBLE_DEVICES=0,1,2,3

DATA_DIR=$HOME/project/text-generation/data/transformer-xl/low_resource
OUT_DIR=$DATA_DIR/output

mkdir $OUT_DIR

python run_lm_finetuning.py --train_data_file $DATA_DIR/input-text.txt --output_dir $OUT_DIR --model_type 'transfo-xl-wt103' --model_name_or_path 'transfo-xl-wt103' --do_train --block_size 512 --per_gpu_train_batch_size 1 --num_train_epochs 4 --logging_steps 250 --save_steps 1000
