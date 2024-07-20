function Out = Prepare_Data_norm(dset,Parm)

TrueLabel = dset.train_labels;
Out.YTest=categorical(dset.test_labels)';
Out.YTrain=categorical(TrueLabel)';
train_layers = length(dset.Xtrain);
q=1:length(TrueLabel);
clear idx


num_class = length(dset.class);
for j=1:num_class
%    rng=find(dset.train_labels==dset.class(j));
    rng=find(strcmp(dset.train_labels,dset.class(j)));
   % rng=q(double(TrueLabel)==j);
    rand('seed',Parm.Seed);
    idx{j} = rng(randperm(length(rng),round(length(rng)*Parm.ValidRatio)));
end
idx=cell2mat(idx);
for i =1:train_layers
dset.XValidation{i} = dset.Xtrain{i}(:,idx);
dset.Xtrain{i}(:,idx) = [];
end
Out.YValidation = Out.YTrain(idx);
Out.YTrain(idx) = [];

for i = 1:train_layers
for dsz=1:size(dset.Xtrain{1},2)
        Out.Max=max(dset.Xtrain{i}(:,dsz));
        Out.Min=min(dset.Xtrain{i}(:,dsz));
        dset.Xtrain{i}(:,dsz)=(dset.Xtrain{i}(:,dsz)-Out.Min)/(Out.Max-Out.Min);
end
for dsz=1:size(dset.XValidation{1},2)
        Out.Max=max(dset.XValidation{i}(:,dsz));
        Out.Min=min(dset.XValidation{i}(:,dsz));
        dset.XValidation{i}(:,dsz) = (dset.XValidation{i}(:,dsz)-Out.Min)/(Out.Max-Out.Min);
end
for dsz=1:size(dset.Xtest{i},2)
        Out.Max=max(dset.Xtest{i}(:,dsz));
        Out.Min=min(dset.Xtest{i}(:,dsz));
       dset.Xtest{i}(:,dsz) = (dset.Xtest{i}(:,dsz)-Out.Min)/(Out.Max-Out.Min);
end
end


pos = dset.pos;

z = zeros(10,19);
for k = 1:train_layers
for j = 1:size(dset.Xtrain{k},2)
for i = 1:size(dset.Xtrain{k},1)
   z(pos(i,1)+1,pos(i,2)+1,k,j) = dset.Xtrain{1,k}(i,j);   
end
Out.XTrain(:,:,k,j) = imresize(z(:,:,k,j),[Parm.Max_Px_Size,Parm.Max_Px_Size]);
end
end
Out.Ztrain = z;

z = zeros(10,19);
for k = 1:train_layers
for j = 1:size(dset.XValidation{k},2)
for i = 1:size(dset.XValidation{k},1)
   z(pos(i,1)+1,pos(i,2)+1,k,j) = dset.XValidation{1,k}(i,j);   
end
Out.XValidation(:,:,k,j) = imresize(z(:,:,k,j),[Parm.Max_Px_Size,Parm.Max_Px_Size]);
end
end
Out.Zvalidation = z;

z = zeros(10,19);
for k = 1:train_layers
for j = 1:size(dset.Xtest{k},2)
for i = 1:size(dset.Xtest{k},1)
   z(pos(i,1)+1,pos(i,2)+1,k,j) = dset.Xtest{1,k}(i,j);   
end
Out.XTest(:,:,k,j) = imresize(z(:,:,k,j),[Parm.Max_Px_Size,Parm.Max_Px_Size]);
end
end
Out.Ztest = z;


Out.A=Parm.Max_Px_Size;
Out.B = Parm.Max_Px_Size;
Out.C = size(Out.XTrain,3);

end


