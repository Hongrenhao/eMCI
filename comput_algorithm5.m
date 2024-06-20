function [Xtrain] = comput_algorithm5(st_data,sc_data)

Xtrain{1} = corr(st_data,sc_data,'type','Pearson');

Xtrain{2}=1-pdist2(st_data',sc_data','cosine');

Xtrain{3} = -1/2*log(1-Xtrain{1}.^2);


end
