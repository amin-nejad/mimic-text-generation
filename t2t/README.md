### Rouge installation

First we install ROUGE-1.5.5 - the definitive ROUGE implementation:
```
sudo apt install subversion
svn checkout https://github.com/andersjo/pyrouge/trunk/tools/ROUGE-1.5.5
sudo cpan App::cpanminus
sudo cpanm XML::DOM
ROUGE_EVAL_HOME=/absolute/path/to/ROUGE-1.5.5/data/
export ROUGE_EVAL_HOME
```

Next, we setup the easy-to-use `pyrouge` python wrapper for ROUGE-1.5.5 and test it to ensure it is working properly:
```
git clone https://github.com/bheinzerling/pyrouge
cd pyrouge
python setup.py install
pyrouge_set_rouge_path /absolute/path/to/ROUGE-1.5.5/
python -m pyrouge.test
```

If the test passes, you should see something like:

```
Ran 11 tests in 6.322s
OK
```

A common occurrence is that it fails with the `"Cannot open exception db file for reading: data/WordNet-2.0.exc.db"` error message. If this is the case, follow the instructions below:
```
cd /absolute/path/to/ROUGE-1.5.5/

cd data/WordNet-2.0-Exceptions/
rm WordNet-2.0.exc.db # only if it exists
./buildExeptionDB.pl . exc WordNet-2.0.exc.db

cd ../
rm WordNet-2.0.exc.db # only if it exists
ln -s WordNet-2.0-Exceptions/WordNet-2.0.exc.db WordNet-2.0.exc.db
```
