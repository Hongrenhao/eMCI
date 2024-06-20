clc
clear
close all
for uu=1:10
    %% Define parameters
    close all
    clear Out
    clear net
    clear dset
    load dset_poster_change6
    Parm = Parameters_2();
    dset=dealdata_function_rng(dset,Parm);
    k=5;
    [Xdata1,Xdata2,Xdata3,Xlabels]= mySMOTE_tyy(dset.Xtrain,dset.train_labels,k);
    dset.Xtrain{1}=Xdata1';
    dset.Xtrain{2}=Xdata2';
    dset.Xtrain{3}=Xdata3';
    dset.train_labels= Xlabels';
    clear Xdata1 Xdata2 Xdata3 Xlabels

    %% convert vector to pseudo image
    Out = Prepare_Data_norm3_TYY_rng(dset,Parm);

    %% training net
    net = makeobjFun(Out,Parm);

    %% test model
    [YPred,probs] = classify(net,Out.XTest);
    accuracy = mean(YPred == Out.YTest);

    %% obtain activition maps
    %SML = calculate_SML(net,Out);

    %% feature selection
    %[Genes] = featureSelection(SML,Out,class,inputsize);
    eval(['save the_data_smote',num2str(uu)]);
    uu

end








