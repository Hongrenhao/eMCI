function class_numR2_use = get_data(mydata,classes,train_labels)
%% normalise
for dsz=1:size(mydata,2)
        Out.Max=max(mydata(:,dsz));
        Out.Min=min(mydata(:,dsz));
        mydata_norm(:,dsz) = (mydata(:,dsz)-Out.Min)/(Out.Max-Out.Min);
end

%% get every class's finally result 
classes=categorical(classes);

for cls = 1:length(classes) 
    SMPLE=find(train_labels==classes(cls));  
    SMPLE_class{cls} =SMPLE;
    class_num(:,cls)=mean(mydata_norm(:,SMPLE),2);
end
class_num2 = diag(1./sum(class_num,2))*class_num;
class_numR2_use=class_num2;

end