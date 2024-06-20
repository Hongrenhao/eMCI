function [Genes] = featureSelection(Rclass,Out,class,inputsize)

[~,layer] = size(Out.Xp);
nclass = length(class);
for l = 1:layer
for j = 1:nclass
R = [];
for i = 1:inputsize(1)
    R = [R;Rclass(:,i,1,j)];
end
[a,b] = sort(R,'descend');
IND_xyp = sub2ind(inputsize,Out.Xp{l},Out.Yp{l});
Genes{l,j} = [];
for i = 1:(Out.A*Out.B)
    q = (IND_xyp == b(i));
    if sum(q)~= 0 
    [r,gn]=sort(q,'descend');
    G = gn(1:sum(r));
    else
    G = [];
    end
    Genes{l,j} = [Genes{l,j},G];
    if length(Genes{l,j})>100
        break
    end
    i
end
end
end
end
