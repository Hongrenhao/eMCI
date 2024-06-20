function [xp,yp,A,B,Base] = Cart2Pixel(Q,A,B,st_pos1,st_pos2)

x=st_pos1;
y=st_pos2;
[n,~]=size(Q.data);

% should have a nearly square bounding rectangle
[xrect,yrect] = minboundrect(x,y);

%{
figure
hold on;
plot(xrect,yrect,'k-');
plot(x,y,'o');
%}
%gradient (m) of a line y=mx+c
grad = (yrect(2)-yrect(1))/(xrect(2)-xrect(1));
theta = atan(grad);

%Rotation matrix
%theta=180-theta
R=[cos(theta) sin(theta);-sin(theta) cos(theta)];

% rotated rectangle
zrect = R*[xrect';yrect'];

% rotated data
z = R*[x';y'];


%plot(z(1,:),z(2,:),'o');
%plot(zrect(1,:),zrect(2,:),'r-');
%axis square

% % log transform ########
% zrect=zrect'; z=z';
% z=z-min(z);
% z=z./max(z);
% z=log10(z+1);
% z=z';
% zrect=zrect-min(zrect);
% zrect=zrect./max(zrect);
% zrect=log10(zrect+1);
% zrect=zrect';
% figure; hold on;
% plot(z(1,:),z(2,:),'o');
% plot(zrect(1,:),zrect(2,:),'r-');
% axis square
% % ######################


% Find nearest points
%tic
min_dist = Inf;
min_p1 = 0;
min_p2 = 0;
for p1 = 1:n
    for p2 = p1+1:n
        d = (z(1,p1)-z(1,p2))^2+(z(2,p1)-z(2,p2))^2;
        if d < min_dist && p1 ~= p2 && d>0
            min_p1 = p1;
            min_p2 = p2;
            min_dist = d;
        end
    end
end
%Time=toc
%plot([z(1,min_p1),z(1,min_p2)],[z(2,min_p1),z(2,min_p2)],'k.');

% Find distance between two nearest points
dmin = norm(z(:,min_p1)-z(:,min_p2));

% Find coordinates of pixel frame (A,B)
rec_x_axis = abs(zrect(1,1)-zrect(1,2));
rec_y_axis = abs(zrect(2,2)-zrect(2,3));

% if dmin is sqrt(2)del, then what is A and B in terms of del (where del is
% one pixel length)
if exist('A')==0 & exist('B')==0
Precision_old=sqrt(2);
A = ceil(rec_x_axis*Precision_old/dmin);
B = ceil(rec_y_axis*Precision_old/dmin);
%Max_Px_Size = 50;%300;
if max([A,B]) > Q.Max_Px_Size
    Precision = Precision_old*Q.Max_Px_Size/max([A,B]);
    A = ceil(rec_x_axis*Precision/dmin);
    B = ceil(rec_y_axis*Precision/dmin);
end
end
%A=25; B=25;

% Transform from cartesian coordinates to pixels
xp = round(1+(A*(z(1,:)-min(z(1,:)))/(max(z(1,:))-min(z(1,:)))));
yp = round(1+(-B)*(z(2,:)-max(z(2,:)))/(max(z(2,:))-min(z(2,:))));
A=max(xp);
B=max(yp);
Base = 1; 