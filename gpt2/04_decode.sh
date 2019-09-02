#!/bin/bash

export CUDA_VISIBLE_DEVICES=0

cd ./gpt-2

MODEL='run1'
DATA_DIR=../../data/gpt2/low_resource
INPUT_FILE=$DATA_DIR/test-input-text.txt
OUTPUT_FILE=$DATA_DIR/test-output-text.txt
TOP_K=0
TEMP=1
BS=1

ln -sf ../../models/117M/encoder.json checkpoint/$MODEL/
ln -sf ../../models/117M/hparams.json checkpoint/$MODEL/
ln -sf ../../models/117M/vocab.bpe checkpoint/$MODEL/

ln -sf ../checkpoint/$MODEL/ models/ 

python src/generate_conditional_samples.py --input_file $INPUT_FILE --output_file $OUTPUT_FILE --model_name $MODEL --top_k $TOP_K --temperature $TEMP --batch_size $BS
