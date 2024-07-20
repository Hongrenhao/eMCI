%Kfoldresult = [];
k=6;
species = Out.YTest;
test = Out.XTest;
%species = Out.YTest;
%test = Out.XTest;
indices = crossvalind('Kfold',species,5); %10为交叉验证折
for i = 1:5 %实验记进行10次(交叉验证折数)，求10次的平均值作为实验结果，
    index= (indices == i); 
    indextrain = ~index;  %产生测试集合训练集索引
    [class,scores] = classify(net,test(:,:,:,indextrain));
    %classperf(cp,cellstr(class),indextrain);
    acc = mean(species(indextrain)==class);
    %[a,b,c,auc] = perfcurve(species(indextrain),scores(:,2),'S');
    Kfoldresult.acc(i,k) = acc;
    %Kfoldresult.auc(i,k) = auc;
    %Kfoldresult.a{i,k} = a;
    %Kfoldresult.b{i,k} = b;
end


