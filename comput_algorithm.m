function [Xtrain] = comput_algorithm(st_data,sc_data)

Xtrain{1} = corr(st_data,sc_data,'type','Pearson');

Xtrain{2} = -1/2*log(1-Xtrain{1}.^2);

Xtrain{3}=Xtrain{1}.^2;

end
