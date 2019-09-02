export CUDA_VISIBLE_DEVICES=0,1,2,3

DATA_DIR=../data/transformer-xl/low_resource

python ./run_lm_finetuning.py \ 
    --train_data_file $DATA_DIR/input-text.txt \
    --eval_data_file $DATA_DIR/val-input-text.txt \
    --output_dir $DATA_DIR \
    --model_type 'transfo-xl-wt103' \
    --model_name_or_path 'transfo-xl-wt103' \
    --do_train \
    --do_eval \
    --block_size 512 \
    --per_gpu_train_batch_size 2 \
    --per_gpu_eval_batch_size 2 \
    --num_train_epochs 3 \
    --logging_steps 250 \
    --save_steps 500