# Instructions

Firstly clone the gpt-2 repo and download the small model:

```
git clone https://github.com/nshepperd/gpt-2
cd gpt-2
python download_model.py 117M
```

Returning back to the directory with the scripts:

1. Run Preprocessing Notebook
2. Run encoding bash script: `./02_encode.sh`
3. Run training bash script: `nohup ./03_train.sh > train.out &`