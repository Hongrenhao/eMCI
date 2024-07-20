%% get fanjuanji result
clc
clear
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
train_labels=dset.train_labels;
classes=dset.class;
sc_data_norm=sc_data./sum(sc_data,2);
norm_st_data=st_data./sum(st_data,2);

mydata_all =comput_algorithm(norm_st_data,sc_data_norm);

class_num_original_use1=get_data(mydata_all{1},classes,train_labels);
class_num_original_use2=get_data(mydata_all{2},classes,train_labels);
class_numR2_use=get_data(mydata_all{3},classes,train_labels);

class_num_mean=(class_num_original_use1+class_numR2_use+class_num_original_use2)/3;
class_num_mean_use = diag(1./sum(class_num_mean,2))*class_num_mean;
for j=1:6
    figure
    scatter(pos(:,1),pos(:,2),20,class_num_mean_use(:,j),'filled');
    map = [1 1 1;1 0.8 0.8;1 0.6 0.6; 1 0.4 0.4; 1 0.2 0.2; 1 0 0];
    colormap(map)
end
deconvolution_result=class_num_mean_use;
save deconvolution_result deconvolution_result