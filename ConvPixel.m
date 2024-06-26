function M = ConvPixel(FVec,xp,yp,A,B,Base,FIG)

if nargin==6
    FIG=0;
end

n=length(FVec);
% Plot in pixels
M=ones(A,B)*Base;
for j=1:n
    M(xp(j),yp(j))=FVec(j);
end

% if (xp,yp) has some duplicates then value in M will be overwritten by the
% last (xp,yp) value used in the for loop. Therefore, it would be better to
% find any duplicates and use an average of these duplicate values in M.

zp=[xp;yp];
[~,~,ic]=unique(zp','rows');
ic=ic';

Len_ic = 1:length(ic);
ic_pos = unique(ic(sum(ic==ic')>1));%Len_ic(hist(ic)>1);
for j=1:length(ic_pos)
    duplicate_pos = Len_ic(ic==ic_pos(j));
    f=0;
    for k=1:length(duplicate_pos)
        f=f+FVec(duplicate_pos(k));
        %M(xp(duplicate_pos(k)),yp(duplicate_pos(k))) = FVec(duplicate_pos(k))/length(duplicate_pos);
    end
    M(xp(duplicate_pos(1)),yp(duplicate_pos(1))) = f/length(duplicate_pos);
end

if FIG==1
    %figure; imshow(M');
    %figure; imagesc(M);
end

M = uint8(mat2gray(M)*255);
end