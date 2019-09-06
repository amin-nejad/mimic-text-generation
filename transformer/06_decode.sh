#!/bin/bash

BASE=$HOME/project/text-generation # change this as necessary
PREPROC=$BASE/data/preprocessed/low_resource
TEST_FILE=$PREPROC/src-test.txt

split -n l/4 $TEST_FILE $PREPROC/temp_
for f in $PREPROC/temp_*; do mv $f $PREPROC/`basename $f `.txt; done;

PROBLEM=mimic_discharge_summaries
MODEL=transformer
HPARAMS=transformer_base
DATA_DIR=$BASE/data/t2t_experiments/transformer/low_resource/full_context/data
TRAIN_DIR=$BASE/data/t2t_experiments/transformer/low_resource/full_context/output
USR_DIR=$BASE/transformer

DECODE_FILE_0=$PREPROC/temp_aa.txt
DECODE_FILE_1=$PREPROC/temp_ab.txt
DECODE_FILE_2=$PREPROC/temp_ac.txt
DECODE_FILE_3=$PREPROC/temp_ad.txt

BEAM_SIZE=4
ALPHA=0.6
DBS=4
EXTRA_LEN=50
HPARAMS_OVERRIDE="max_length=10000,max_target_seq_length=512,max_input_seq_length=512"

CUDA_VISIBLE_DEVICES=0 t2t-decoder \
    --t2t_usr_dir=$USR_DIR \
    --data_dir=$DATA_DIR \
    --problem=$PROBLEM \
    --model=$MODEL \
    --hparams_set=$HPARAMS \
    --hparams=$HPARAMS_OVERRIDE \
    --output_dir=$TRAIN_DIR \
    --decode_hparams="beam_size=$BEAM_SIZE,alpha=$ALPHA,batch_size=$DBS,extra_length=$EXTRA_LEN" \
    --decode_from_file=$DECODE_FILE_0 \
    --decode_to_file=$TRAIN_DIR/tgt-decoded-0.txt &

CUDA_VISIBLE_DEVICES=1 t2t-decoder \
    --t2t_usr_dir=$USR_DIR \
    --data_dir=$DATA_DIR \
    --problem=$PROBLEM \
    --model=$MODEL \
    --hparams_set=$HPARAMS \
    --hparams=$HPARAMS_OVERRIDE \
    --output_dir=$TRAIN_DIR \
    --decode_hparams="beam_size=$BEAM_SIZE,alpha=$ALPHA,batch_size=$DBS,extra_length=$EXTRA_LEN" \
    --decode_from_file=$DECODE_FILE_1 \
    --decode_to_file=$TRAIN_DIR/tgt-decoded-1.txt &
    
CUDA_VISIBLE_DEVICES=2 t2t-decoder \
    --t2t_usr_dir=$USR_DIR \
    --data_dir=$DATA_DIR \
    --problem=$PROBLEM \
    --model=$MODEL \
    --hparams_set=$HPARAMS \
    --hparams=$HPARAMS_OVERRIDE \
    --output_dir=$TRAIN_DIR \
    --decode_hparams="beam_size=$BEAM_SIZE,alpha=$ALPHA,batch_size=$DBS,extra_length=$EXTRA_LEN" \
    --decode_from_file=$DECODE_FILE_2 \
    --decode_to_file=$TRAIN_DIR/tgt-decoded-2.txt &

CUDA_VISIBLE_DEVICES=3 t2t-decoder \
    --t2t_usr_dir=$USR_DIR \
    --data_dir=$DATA_DIR \
    --problem=$PROBLEM \
    --model=$MODEL \
    --hparams_set=$HPARAMS \
    --hparams=$HPARAMS_OVERRIDE \
    --output_dir=$TRAIN_DIR \
    --decode_hparams="beam_size=$BEAM_SIZE,alpha=$ALPHA,batch_size=$DBS,extra_length=$EXTRA_LEN" \
    --decode_from_file=$DECODE_FILE_3 \
    --decode_to_file=$TRAIN_DIR/tgt-decoded-3.txt &
