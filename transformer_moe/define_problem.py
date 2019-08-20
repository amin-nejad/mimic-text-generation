import tensorflow as tf
#tf.enable_eager_execution()
from tensor2tensor.utils import trainer_lib
RANDOM_SEED = 301
trainer_lib.set_random_seed(RANDOM_SEED)
from tensor2tensor.data_generators import problem
from tensor2tensor.data_generators import text_problems
from tensor2tensor.utils import registry


@registry.register_problem

class MimicDischargeSummaries(text_problems.Text2TextProblem):
    
    @property
    def is_generate_per_split(self):
        # our data already has pre-existing splits
        return True

    def generate_samples(self, data_dir, tmp_dir, dataset_split):
        
        del tmp_dir
        
        directory = "data/preprocessed/" 
        
        _train = (dataset_split == problem.DatasetSplit.TRAIN)
        _eval = (dataset_split == problem.DatasetSplit.EVAL)
        
        dataset = "train" if _train else "val" if _eval else "test"
        
        src = directory + "src-" + dataset + ".txt"
        tgt = directory + "tgt-" + dataset + ".txt"
        
        f_src = open(src,'r')
        f_tgt = open(tgt,'r')
        
        context_data = f_src.readline()
        discharge_summary = f_tgt.readline()

        while context_data:
            yield {
              "inputs"  : context_data,
              "targets" : discharge_summary,
            }
            
            context_data = f_src.readline()
            discharge_summary = f_tgt.readline()
            
        f_src.close()
        f_tgt.close()

    @property
    def vocab_type(self):
        # SUBWORD and CHARACTER are fully invertible -- but SUBWORD provides a good
        # tradeoff between CHARACTER and TOKEN.
        return text_problems.VocabType.SUBWORD

    @property
    def approx_vocab_size(self):
        # Approximate vocab size to generate. Only for VocabType.SUBWORD.
        return 2**15  # ~32k - this is the default setting

    @property
    def dataset_splits(self):
        return [{
            "split": problem.DatasetSplit.TRAIN,
            "shards": 80
        }, {
            "split": problem.DatasetSplit.EVAL,
            "shards": 10
        }, {
            "split": problem.DatasetSplit.TEST,
            "shards": 10
        }]
