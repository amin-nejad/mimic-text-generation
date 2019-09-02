#!/bin/bash

export CUDA_VISIBLE_DEVICES=0

DATA=$HOME/project/text-generation/data/gpt2/low_resource

cd ./gpt-2

PYTHONPATH=src ./train.py --dataset $DATA/input-text.txt.npz --val_dataset $DATA/val-input-text.txt.npz --sample_every=10000 --save_every=10000 --optimizer='adam' --model_name=117M --val_every=1000 --batch_size=2
