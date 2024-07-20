clc
clear
close all
load map_all_LIME_LUNG_multiple
load classes
load pos
pos_all{1}=pos;

the_class={'6PCW','7PCW','8PCW','8.5P','10PC','11.5','13PC'};

for i=1:size(map_all_LIME,2)
    clear AAA current_pos
    AAA=map_all_LIME{i};
    if isempty(AAA)
        THE_ALL_CAM{i}=[];
        continue;
    end

    current_class=classes{i};
    the_chr=current_class(1:4);
    %find(the_class==the_chr);
    indes=contains(the_class,the_chr);  
    current_pos=pos_all{indes};
     for j=1:size(AAA,3)
        BBB=AAA(:,:,j);
        THE_ALL_CAM{i}(:,:,j)=imresize(BBB,[max(current_pos(:,1))+1,max(current_pos(:,2))+1]);
     end
end


for k=1:size(THE_ALL_CAM,2)
    THE_ALL_CAM1=THE_ALL_CAM{k};
    if isempty(THE_ALL_CAM1)
        THE_ALL_CAM2{k}=[];
        continue;
    end

    for j=size(THE_ALL_CAM1,3):-1:1
        if sum(THE_ALL_CAM1(:,:,j))==0
            THE_ALL_CAM1(:,:,j)=[];
        end
    end
    THE_ALL_CAM2{k}=mean(THE_ALL_CAM1,3);
end



for k=1:size(THE_ALL_CAM,2)
    THE_ALL_CAM1=THE_ALL_CAM{k};
    if isempty(THE_ALL_CAM1)
        class_num_mean{k}=[];
        continue;
    end
    current_class=classes{k};
    the_chr=current_class(1:4);
    %find(the_class==the_chr);
    indes=contains(the_class,the_chr);
    current_pos=pos_all{indes};
    for j=1:size(THE_ALL_CAM1,3)
        for i=1:size(current_pos,1)
            class_num_mean{k}(i,j)=THE_ALL_CAM1(current_pos(i,1)+1,current_pos(i,2)+1,j);
        end
    end
end


for i=1:size(class_num_mean,2)
    the_data=class_num_mean{i};
    the_data(:,all(the_data==0,1)) = [];
    class_num_mean_use1{i}=the_data;
end



for i=1:size(class_num_mean_use1,2)
    class_num_mean_use_mean{i}=mean(class_num_mean_use1{i},2);
end


%%
for j=1:size(class_num_mean_use_mean,2)
    if isempty(class_num_mean_use_mean{j})
        continue;
    end
    current_class=classes{j};
    the_chr=current_class(1:4);
    %find(the_class==the_chr);
    indes=contains(the_class,the_chr);
    current_pos=pos_all{indes};
    for i=1:size(current_pos,1)
        picture_result_original_input{j}(current_pos(i,1)+1,current_pos(i,2)+1)=class_num_mean_use_mean{j}(i);       
    end
end


%%


load colormap_my

%h = figure;
k=1;
UU=[2,2,2,2,2,2];
kkk=[5,5,5,5,5,5];
for i=1:6

    if isempty(class_num_mean_use_mean{i})
        continue;
    end
    current_class=classes{i};
    the_chr=current_class(1:4);
    %find(the_class==the_chr);
    indes=contains(the_class,the_chr);
    current_pos=pos_all{indes};


    j=i;

    class_num_mean_use_mean_my=class_num_mean_use_mean{i};
    class_num_mean_use_mean_my=(class_num_mean_use_mean_my-min(class_num_mean_use_mean_my))/(max(class_num_mean_use_mean_my)-min(class_num_mean_use_mean_my));
    for jj=1:size(current_pos,1)
         picture_result_original_input_my1(current_pos(jj,1)+1,current_pos(jj,2)+1)=class_num_mean_use_mean_my(jj);
         pic_index(current_pos(jj,1)+1,current_pos(jj,2)+1)=jj;
    
    end
    %picture_result_original_input_my=class_num_mean_use_mean_my;
    %get single and oushu 
    s=0;
    for i2=1:size(picture_result_original_input_my1,2)
        ttt1=picture_result_original_input_my1(:,i2);
        uuu1=pic_index(:,i2);

        if mod(i2,2) ==1  %if it is single
            mm=2:2:size(ttt1,1);
            ttt=ttt1;
            uuu=uuu1;
            s=sum(ttt(mm))+s;
            ttt(mm)=[];
            uuu(mm)=[];
            picture_result_original_input_my2(:,i2)=ttt; 
            pic_index2(:,i2)=uuu; 

        else
            ttt=ttt1;
            uuu=uuu1;
            mm=1:2:size(ttt1,1);
            s=sum(ttt(mm))+s;
            ttt(mm)=[];
            uuu(mm)=[];
            picture_result_original_input_my2(:,i2)=ttt;  
            pic_index2(:,i2)=uuu; 

        end

    end
    k=1;
    % get new position
    for i1=1:size(pic_index2,1)
        for j1=1:size(pic_index2,2)
            the_new_position(k,1)=i1;
            the_new_position(k,2)=j1;
            the_new_position(k,3)=pic_index2(i1,j1);
            k=k+1;
        end
    end
   the_new_position1=sortrows(the_new_position,3);
   the_new_position1(find(the_new_position1(:,3)==0),:)=[];

    picture_result_original_input_my=picture_result_original_input_my2;
   
    figure
     
    hold on
    [U,V] = gradient(picture_result_original_input_my,0.2,0.2);%计算归因值梯度
    hold on
    U1 = U(min(current_pos(:,1))/2:UU(i):max((current_pos(:,1))+1)/2,min(current_pos(:,2))+1:UU(i):max(current_pos(:,2))+1);
    V1= V(min(current_pos(:,1))/2:UU(i):max((current_pos(:,1))+1)/2,min(current_pos(:,2))+1:UU(i):max(current_pos(:,2))+1);

    [M,c]=contourf(picture_result_original_input_my(:,:),kkk(i),'-','color',[0.98 0.5 0.45]); %绘制归因值等高线，也可以用contour函数绘制，看个人喜好
    c.LineWidth = 1;
    %c.FaceAlpha = 0.25;

    ch=get(c,'children');

    shenlan=[255 255 255;220 230 250;200 200 230;180 170 210;130 155 200; 93 131 183]./255;
    huang2=[255 255 255;250 250 240;248 245 220;245 240 200;245 232 180; 245 226 167]./255;

    colormap(CustomColormap_infected2);     
    hold on 

    pos2=current_pos+1;
    %scatter(the_new_position1(:,2),the_new_position1(:,1),106,'k','filled','MarkerFaceAlpha',.1,'MarkerEdgeAlpha',.1)
    %scatter(the_new_position1(:,2),the_new_position1(:,1),106,[0.5 0.5 0.5],'filled')
    hold on
    quiver(min(current_pos(:,2))+1:UU(i):max(current_pos(:,2))+1,min(current_pos(:,1))/2:UU(i):(max(current_pos(:,1))+1)/2,U1,V1,'k','AutoScaleFactor',1)
    xlim ([min(current_pos(:,2)) max(current_pos(:,2))+1])    %调节横轴数值范围
    ylim ([min(current_pos(:,1))/2 (max(current_pos(:,1))+1)/2])   %调节纵轴数值范围
    daspect([50 18 1])  %调节横纵比
    ax=gca;
    ax.XAxis.Visible='off';
    ax.YAxis.Visible='off';
    ax.ZAxis.Visible='off';

    title(classes(i),'fontname','Times New Roman','Color','k','FontSize',14)
    k=k+1;

%     figure
%     scatter(current_pos(:,2),current_pos(:,1),78,'k','filled','MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2)
%     title(classes(i),'fontname','Times New Roman','Color','k','FontSize',14)
%     daspect([25 18 1])
%     ax=gca;
%     ax.XAxis.Visible='off';
%     ax.YAxis.Visible='off';
%     ax.ZAxis.Visible='off';

end

