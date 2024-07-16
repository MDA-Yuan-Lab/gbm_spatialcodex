## Topological changes of glioblastoma’s spatial immune niches in longitudinal primary and recurrent tumors

**Authors**: Simon P. Castillo, Afrooz Jahedi, Pravesh Gupta, Aaron Mayer, Jason T. Huse, Yinyin Yuan, Kasthuri S. Kannan, and Krishna P.L. Bhat.

**Corresponding authors**: Simon P. Castillo (spcastillo@mdanderson.org, MD Anderson) and Krishna P.L. Bhat (bhat.krishna@mayo.edu, Mayo Clinic).

**Repository maintainer**:  Simon P. Castillo (spcastillo@mdanderson.org, MD Anderson)

This repository contains the code used in the manuscript (main code) and a test code with a sample data set to reproduce some of the steps. Further data access can be requested tot he corresponding authors.

### Repository content

    .
    ├── main_code  <-------------------------------------------#  
    │   ├── python_gat <---------------------------------------#
    │   │   ├── GAT  <-----------------------------------------# 
    │   │   │   ├── requirements.txt  <------------------------# 
    │   │   │   ├── step0_data_preparation.py  <---------------#
    │   │   │   ├── step1_modelarchitecture.py  <--------------#
    │   │   │   ├── step2_model-train.py  <--------------------#
    │   │   │   ├── step3_loadmodel_inference.py  <------------# 
    │   ├── r <------------------------------------------------# 
    │   │   ├── step0_qc-phenotyping.R  <----------------------# 
    │   │   ├── step1_spatial-process.R  <---------------------# 
    │   │   ├── step2_network-from-spatial.R  <----------------#
    │   │   ├── step3_prepare_data_GAT.R  <--------------------#
    │   │   ├── misc <-----------------------------------------#
    ├── test_code  <-------------------------------------------# 
    │   ├── python_gat <---------------------------------------# 
    │   │   ├── GAT  <-----------------------------------------#
    │   │   │   ├── requirements.txt  <------------------------#
    │   │   │   ├── main_gat.py  <-----------------------------#
    │   │   │   ├── model.py  <--------------------------------#
    │   │   │   ├── data  <------------------------------------#
    │   │   │   │   ├── spatial_to_gat  <----------------------#
    │   │   │   │   │   ├── features_P04primary_reg005.csv  <--# 
    │   │   │   │   │   ├── links_1um_P04primary_reg005.csv  <-# 
    │   │   │   │   │   ├── links_30um_P04primary_reg005.csv  <# 
    │   │   │   ├── ckpt  <------------------------------------# 
    │   │   │   │   ├── spatial-agnostic  <--------------------# 
    │   │   │   │   │   ├── spatialagnostic_20240331-1824  <---# 
    │   │   │   │   │   │   ├── checkpoint  <------------------# 
    │   │   │   │   ├── spatial-aware  <-----------------------# 
    │   │   │   │   │   ├── spatialaware_20240401-0025  <------# 
    │   │   │   │   │   │   ├── checkpoint  <------------------# 
    │   ├── r <------------------------------------------------# 
    │   │   ├── codes  <---------------------------------------# 
    │   │   │   ├── processing  <------------------------------# 
    │   │   │   │   ├── step1_spatial-process.R  <-------------# 
    │   │   │   │   ├── step2_network-from-spatial.R  <--------# 
    │   │   │   │   ├── step3_prepare_data_GAT.R  <------------# 
    │   │   ├── data  <----------------------------------------# 
    │   │   │   ├── coordinatescorrection.csv  <---------------# 
    │   │   │   ├── masks  <-----------------------------------# 
    │   │   │   │   ├── P04primary  <--------------------------# 
    │   │   │   │   │   ├── P04_primary_reg005.png.txt  <------# 
    │   │   │   │   │   ├── P04primary_reg005-labels.png <-----# 
    │   │   ├── step0_output-qc  <-----------------------------# 
    │   │   │   ├── phenotyped_data_P04_primary_reg05.rdata  <-# 
    ├── LICENSE
    └── README.md
`
