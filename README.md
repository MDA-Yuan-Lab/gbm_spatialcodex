## Topological changes of glioblastoma’s spatial immune niches in longitudinal primary and recurrent tumors

**Authors**: Simon P. Castillo, Afrooz Jahedi, Pravesh Gupta, Aaron Mayer, Jason T. Huse, Yinyin Yuan, Kasthuri S. Kannan, and Krishna P.L. Bhat.

**Corresponding authors**: Simon P. Castillo (spcastillo@mdanderson.org, MD Anderson) and Krishna P.L. Bhat (bhat.krishna@mayo.edu, Mayo Clinic).

**Repository maintainer**:  Simon P. Castillo (spcastillo@mdanderson.org, MD Anderson)

This repository contains the code used in the manuscript (main code) and a test code with a sample data set to reproduce some of the steps. Further data access can be requested to the corresponding authors.

### Repository content

    .
    ├── main_code  <-------------------------------------------# Code used in the manuscript 
    │   ├── python_gat <---------------------------------------# Python code for the graph attention network (GAT)
    │   │   ├── GAT  <-----------------------------------------# GAT subdir
    │   │   │   ├── requirements.txt  <------------------------# Requirements file
    │   │   │   ├── step0_data_preparation.py  <---------------# Data preparation for GAT
    │   │   │   ├── step1_modelarchitecture.py  <--------------# Model architecture
    │   │   │   ├── step2_model-train.py  <--------------------# Model training
    │   │   │   ├── step3_loadmodel_inference.py  <------------# Model inference
    │   ├── r <------------------------------------------------# R code for data processing 
    │   │   ├── step0_qc-phenotyping.R  <----------------------# QC and phenotyping based on single cell marker expression
    │   │   ├── step1_spatial-process.R  <---------------------# Spatial modelling
    │   │   ├── step2_network-from-spatial.R  <----------------# Network analyses
    │   │   ├── step3_prepare_data_GAT.R  <--------------------# Prepara data for GAT
    │   │   ├── misc <-----------------------------------------# Misc codes / archive
    ├── test_code  <-------------------------------------------# test code with data from one ROI (selfcontained)
    │   ├── python_gat <---------------------------------------# Python code for phenotype inference on test dataset
    │   │   ├── GAT  <-----------------------------------------# GAT subdir
    │   │   │   ├── requirements.txt  <------------------------# Requirements
    │   │   │   ├── main_gat.py  <-----------------------------# Main code. a .yaml file can be use as a wrapper
    │   │   │   ├── model.py  <--------------------------------# Model architecture
    │   │   │   ├── data  <------------------------------------# Data input to gat
    │   │   │   │   ├── spatial_to_gat  <----------------------# Spatial data and features
    │   │   │   │   │   ├── features_P04primary_reg005.csv  <--# features at cell level 
    │   │   │   │   │   ├── links_1um_P04primary_reg005.csv  <-# adjacency matrix at 1um (ie, spatial-agnostic)
    │   │   │   │   │   ├── links_30um_P04primary_reg005.csv  <# adjacency matrix at 30um (ie, spatial-aware)
    │   │   │   ├── ckpt  <------------------------------------# Model checkpoints
    │   │   │   │   ├── spatial-agnostic  <--------------------# Spatial agnostic model
    │   │   │   │   │   ├── spatialagnostic_20240331-1824  <---# model id subdir
    │   │   │   │   │   │   ├── checkpoint  <------------------# checkpoint
    │   │   │   │   ├── spatial-aware  <-----------------------# Spatial aware model
    │   │   │   │   │   ├── spatialaware_20240401-0025  <------# model id subdir
    │   │   │   │   │   │   ├── checkpoint  <------------------# checkpoint
    │   ├── r <------------------------------------------------# R code for data processing 
    │   │   ├── codes  <---------------------------------------# Codes
    │   │   │   ├── processing  <------------------------------# Processing emulating the processing of the data tailored for test sample
    │   │   │   │   ├── step1_spatial-process.R  <-------------# Spatial modelling
    │   │   │   │   ├── step2_network-from-spatial.R  <--------# Network analyses
    │   │   │   │   ├── step3_prepare_data_GAT.R  <------------# Prepare data for GAT
    │   │   ├── data  <----------------------------------------# Test data
    │   │   │   ├── P04primary_reg005_HE_aligned.tif<----------# HE image
    │   │   │   ├── coordinatescorrection.csv  <---------------# Coordinate correction due to cell coordinates offset relative to mask/mIF
    │   │   │   ├── masks  <-----------------------------------# ROI mask data with cellular tumor 
    │   │   │   │   ├── P04primary  <--------------------------# Test sample
    │   │   │   │   │   ├── P04_primary_reg005.png.txt  <------# Mask information
    │   │   │   │   │   ├── P04primary_reg005-labels.png <-----# Mask (Cellular tumor = 3)
    │   │   ├── step0_output-qc  <-----------------------------# Data used for processing
    │   │   │   ├── phenotyped_data_P04_primary_reg05.rdata  <-# Test data already processed for phenotyping. input for step1...
    ├── LICENSE
    └── README.md
`
