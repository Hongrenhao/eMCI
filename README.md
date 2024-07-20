# eMCI
eMCI: an Explainable Multimodal Correlation Integration Model for Unveiling Spatial Transcriptomics and Intercellular Signaling 

eMCI for MATLAB is a free, open-source code for an explainable multimodal correlation integration method based on a deep neural network framework for multiple synthetic analysis tasks of single-cell RNA-sequencing (scRNA-seq) data and spatial transcriptomics (ST) data. It can provide new insights into the spatial expression patterns underlying cell-type specificity and intercellular communication by employing an attribution algorithm to dissect the visual input.

Contact Email: zeng_tao@gzlab.ac.cn or zengtao@sibs.ac.cn; tanghui2020@scut.edu.cn; scliurui@scut.edu.cn.

############################## eMCI ###############################

eMCI: eMCI for MATLAB is free, open-source code for single/multi-label classification of scRNA-seq data, cell-type deconvolution of ST data and constructing cell type-specific attribution maps.  
(1) Input files include scRNA-seq data and ST data.  
(2) main_compute.m is the main program to execute the eMCI algorithm. The program can be run step by step for each analysis phase.  
(3) Output file with *.mat contains the well-trained model, the predicted accuracy of the test data, the result of cell deconvolution and cell type-specific attribution maps by the LIME method.  
(4) see_deconvolution.m is a program that can view deconvolution results.  
(5) see_Attribution_of_LIME.m is a program that can view attribution results.  

Note:  
(1) The trainNetwork() function in makeobjFun.m is used when training a CNN model, and the Matlab version should comply with: > MATLAB2020a.  
(2) eMCI can be trained on either CPU or GPU. For image classification, a single network can be trained in parallel using multiple GPUs or a local or remote parallel pool to save training time.  
(3) The default CNN model in eMCI adopts a parallel ResNet50 architecture. Please make sure you have installed the Deep Learning Toolbox in MATLAB before running eMCI.  
(4) The default value of MaxEpochs is set to 100 in Parameters.m, which can be adjusted for different datasets taking into account the processing time of training.  
