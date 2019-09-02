#!/bin/bash

DATA=$HOME/project/text-generation/data/gpt2/low_resource

cd ./gpt-2

PYTHONPATH=src ./encode.py $DATA/input-text.txt $DATA/input-text.txt.npz

PYTHONPATH=src ./encode.py $DATA/val-input-text.txt $DATA/val-input-text.txt.npz