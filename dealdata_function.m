function [dset] = dealdata_function(dset,Parm)

num_class = length(dset.class);
for j=1:num_class
        %rng=find(dset.train_labels==dset.class(j));
    rng=find(strcmp(dset.train_labels,dset.class(j)));
    % rng=q(double(TrueLabel)==j);
    rand('seed',Parm.Seed);
    idx{j} = rng(randperm(length(rng),round(length(rng)*Parm.ValidRatio)))
end
idx=cell2mat(idx);
for i =1:3
    dset.Xtest{i} = dset.Xtrain{i}(:,idx);
    dset.Xtrain{i}(:,idx) = [];
end
dset.test_labels = dset.train_labels(idx);
dset.train_labels(idx) = [];
end




