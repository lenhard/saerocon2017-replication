# Replication package for the paper "Are Code Smell Detection Tools Suitable For Detecting Architecture Degradation?"

This study will be published at the 4th Workshop on Software Architecture Erosion and Architectural Consistency (SAEroCon), co-located with the 11th European Conference on Software Architecture (ECSA 2017), in Canterbury, UK, September 11 - 15, 2017.

BibTex entry for the paper:
```
@InProceedings{lenhard2017saerocon,
  author    = {J\"org Lenhard and Mohammad Mahdi Hassan and Martin Blom and Sebastian Herold},
  title     = {"Are Code Smell Detection Tools Suitable For Detecting Architecture Degradation?},
  booktitle = {11th European Conference on Software Architecture Workshops, 4th Workshop on Software Architecture Erosion and Architectural Consistency (SAEroCon)},
  year      = {2017},
  address   = {Canterbury, UK},
  month     = {September},
}
```

The following files are part of the replication package:
 - `classifiers.R`: R script for computing Naive Bayes classifiers based on the data contained in `data-frame.csv` and searching for an optimal model. Instructions on how to execute the script in a custom environment are given as comments in the code.
 - `computation-results.xlsx`: Result tables of the optimal models found that have been presented in the paper
 - `data-frame`: The raw data (classes, response variables, predictor variables) on which the computation is based
