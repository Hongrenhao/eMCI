clc
clear
close all
%% Define parameters
addpath([cd,'/Input Data']);
st_data = readtable('ST_Data_filt_lung_6PCW1.csv'); 
sc_data = readtable('SC_Data_filt_lung_6PCW1.csv'); 
sc_data_features = readtable("genenames_lung_6PCW1.csv");
position = readtable("tissue_positions_list_lung_6PCW1.csv");

labels = readtable('SC_time_metadata_lung_6PCW1.csv', 'Delimiter', ',','ReadVariableNames', true);
%labels = readtable('SC_time_metadata_lung_6PCW1.csv');

dset.features = sc_data_features.ID;
%clear sc_data_features
sc_data = table2array(sc_data);
st_data = table2array(st_data);

dset.train_labels = labels.Celltype';
dset.class = unique(dset.train_labels);
dset.dim = length(dset.features);
dset.pos(:,1) = position.Var2;
dset.pos(:,2) = position.Var3;

pos=dset.pos;
save pos pos
train_labels=dset.train_labels;
save train_labels train_labels
classes=dset.class;

 sc_data_norm=sc_data;

 norm_st_data=st_data;

mydata_all =comput_algorithm(norm_st_data,sc_data_norm);

 dset.Xtrain=mydata_all;

 Parm = Parameters();
 dset=dealdata_function(dset,Parm);

 k=5;
 [Xdata1,Xdata2,Xdata3,Xlabels]= mySMOTE(dset.Xtrain,dset.train_labels,k);
 dset.Xtrain{1}=Xdata1';
 dset.Xtrain{2}=Xdata2';
 dset.Xtrain{3}=Xdata3';
 dset.train_labels= Xlabels';
 clear Xdata1 Xdata2 Xdata3 Xlabels


 %% convert vector to pseudo image
 Out = Prepare_Data_norm(dset,Parm);

%% training net
net = makeobjFun(Out,Parm);

%% test model
[YPred,probs] = classify(net,Out.XTest);
accuracy = mean(YPred == Out.YTest);


%% feature selection

inputSize = net.Layers(1).InputSize(1:2);
classes = net.Layers(end).Classes;

nclass = max(double(classes));

for cls = 1:nclass
    R=zeros(inputSize(1),inputSize(2));
    SMPLE =find(Out.YTest==classes(cls));
    [classfn,score] = classify(net,Out.XTest(:,:,:,SMPLE));
    count = 0;
    for Sample = 1:length(SMPLE)
        if classfn(Sample)==classes(cls)
            map1 = imageLIME(net,Out.XTest(:,:,:,SMPLE(Sample)),classfn(Sample));
            map_all_LIME{cls}(:,:,Sample)=map1;

        end
    end
    cls
end
save map_all_LIME_LUNG_multiple map_all_LIME
