# Replication package for the paper "Are Code Smell Detection Tools Suitable For Detecting Architecture Degradation?"

This study has been published at the 4th Workshop on Software Architecture Erosion and Architectural Consistency (SAEroCon), co-located with the 11th European Conference on Software Architecture (ECSA 2017), in Canterbury, UK, September 11 - 15, 2017.

BibTex entry for the paper:
```
@InProceedings{lenhard2017saerocon,
  author    = {J\"org Lenhard and Mohammad Mahdi Hassan and Martin Blom and Sebastian Herold},
  title     = {Are Code Smell Detection Tools Suitable For Detecting Architecture Degradation?},
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
 
To reproduce the calculations, simply start your favourite R development environment and open `classifiers.R`. The script assumes that the repository is located on your working path. More instructions on how to interpret the output can be found inside the script.

For convenience, the repository contains a Dockerfile which sets up RStudio in a docker container. The advantage of that is that you do not have to install the environment locally, but can access everthing through your brower. To run this repository inside a container, you need to have Docker installed on your system. If you do, `cd` to the directory of the repository and do the following:
 - build an image: `docker build -t saerocon2017-replication .`
 - run the image (RStudio will be available on port 8787): `docker run --rm -p 8787:8787 saerocon2017-replication`
 - open your browser at http://localhost:8787/ 
 - RStudio's default credentials are username: `rstudio`, password: `rstudio`
 - Open `classifiers.R`, read the code and execute it

