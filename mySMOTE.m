%mySMOTE(dset.Xtrain,dset.train_labels,k);
 function [Xdata1,Xdata2,Xdata3,Xlabels]= mySMOTE(data,label,k)
 
 for i=1:size(data,2)
     data{i}=data{i}';
 end

 data1=data{1};
 data2=data{2};
 data3=data{3};
 clear data

 k=5;
 % mySMOTE  Synthetic Minority Oversampling Technique. A technique to
 % generate synthetic samples as given in: https://www.jair.org/media/953/live-953-2037-jair.pdf
 %   Usage:
 %   X_smote = mySMOTE(X, N, k)
 %
 %   Inputs:
 %   allData: Original dataset
%   k: number of nearest neighbors to consider while performing
%   augmentation
%   sortedIDX: sorted labels
% 
%   Outputs:
%   X_smote: augmented dataset containing original data as well.
%   
%   See also datasample, randsample
%% plot the bar plot for number of classes

%% number of each classes
labels=label';
class=unique(labels);
for ii=1:numel(class)
    classNo(ii)=numel(find(ismember(labels,class(ii))==1));
end
%% required addon samples in each minority class
%add on samples will be calculated by taking the difference of each
%classSamples with highest number of class sample
[maximumSamples,sampleClass]=max(classNo); % number of maximum samples
for ii=1:numel(class) 
    X1=data1(find(ismember(labels,class(ii))==1),:);
    T = size(X1, 1);
    samplediff(ii)=maximumSamples-classNo(ii);
    N (ii) = round(samplediff(ii)/ T);
end
%% oversample the minority classes
Xdata1 =[];
Xdata2 =[];
Xdata3 =[];
Xlabels ={};
for ii=1:numel(class)
    X1=data1(find(ismember(labels,class(ii))==1),:);
    X2=data2(find(ismember(labels,class(ii))==1),:);
    X3=data3(find(ismember(labels,class(ii))==1),:);
    T = size(X1, 1);
    X_smote1 = X1;
    X_smote2 = X2;
    X_smote3 = X3;
    X_labels = labels(find(ismember(labels,class(ii))==1),1);
   if N(ii) > 0
    for i = 1:T
        x_labels = {}; 
        [X_smote1,s]= getmoredata(X_smote1,X1,i,k,ii,N);
        [X_smote2,s]= getmoredata(X_smote2,X2,i,k,ii,N);
        [X_smote3,s]= getmoredata(X_smote3,X3,i,k,ii,N);

        x_labels(1:s,1) = class(ii); 
        X_labels = cat(1, X_labels, x_labels);
    end
    ii
   end
   Xdata1 = cat(1,Xdata1,X_smote1);
   Xdata2 = cat(1,Xdata2,X_smote2);
   Xdata3 = cat(1,Xdata3,X_smote3);
   Xlabels = cat(1,Xlabels ,X_labels);
end

 end



