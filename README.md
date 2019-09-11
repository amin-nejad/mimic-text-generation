# mimic-text-generation

This repository contains the code to recreate all our text generation models. This is part of my Master's thesis researching transformer-based Natural Language Generation methods for NLP data augmentation, specifically in the medical field. We use the MIMIC-III dataset.

Follow the steps below:


1. Install the environment
```
conda env create -f environment.yml
```
2. Run the notebooks in the `preprocess` directory sequentially. This assumes you have already downloaded the MIMIC-III dataset and configured it into a Postgres database. If not follow the instructions on https://mimic.physionet.org
3. Ensure you install ROUGE separately. Instructions provided in `ROUGE.md`
4. For each model e.g. `transformer`, enter the directory and run the notebooks or Python files sequentially. These directories contain all the necessary files for further preprocessing, training, decoding and evaluating each individual mode. Some files may need 1 or 2 variables changed to switch between the low resource setting and the full resource setting
5. Voila
