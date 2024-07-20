function [X_smote,s]= getmoredata(X_smote,X,i,k,ii,N)
y = X(i,:);
% find k-nearest samples
[idx, ~] = knnsearch(X,y,'k',k);
% retain only N out of k nearest samples
idx = datasample(idx, N(ii));
x_nearest = X(idx,:);
x_syn = bsxfun(@plus, bsxfun(@times, bsxfun(@minus,x_nearest,y), rand(N(ii),1)), y);
X_smote = cat(1, X_smote,x_syn);
[s,~] = size(x_syn);
end