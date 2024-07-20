function Parm = Parameters()
% Paramaters for the DeepInsight-3D model

Parm.Max_Px_Size = 224; %227 for SqueezeNet, 224 EfficientNetB0 (however, not necessary to change)
Parm.MPS_Fix=1;
Parm.TestRatio = 0.2;         
Parm.ValidRatio = 0.1; % ratio of validation data/Training data
Parm.Seed = 108; % random seed to distribute training and validation sets
Parm.Norm = 2; % Select '1' for Norm-1, '2' for Norm-2 and '0' for automatically select the best Norm (either 1 or 2).
Parm.Threshold = 0.3; %CAM threshold [0,1]

Parm.DesiredGenes = 1200;% number of expected features to be selected
Parm.UsePrevModel = 'n'; % 'y' for yes and 'n' for no (for CNN). For 'y' the hyperparameter of previous stages will be used.
Parm.Stage=1; % '1', '2', '3', '4', '5' depending upon which stage of DeepInsight-FS to run.
Parm.ParallelNet = 0; % if '1' then parallel net (from DeepInsight project) will be used using makeObjFcn2.m
Parm.InitialLearnRate=4.98661e-5;
Parm.Momentum=0.801033;
Parm.L2Regularization=1.25157e-2;
Parm.initialNumFilters = 4;
Parm.filterSize = 12;
Parm.filterSize2 = 2;


Parm.MaxEpochs = 100;
Parm.MaxTime = 50; % (in hours) Max. training time in hours to run a model. 
%Parm.trainingPlot='training-progress'; % 'training-progress' to view training plot otherwise 'none'
Parm.trainingPlot='none';
% ExecutionEnvironment — Hardware resource for training network
%'auto' | 'cpu' | 'gpu' | 'multi-gpu' | 'parallel'
Parm.ExecutionEnvironment = 'gpu';
Parm.miniBatchSize = 256;%256;
Parm.solver = 'sgdm';
Parm.net = resnet50;

end
