close all;
clear all;
clc;

%startopt.m

% search settings
A=[1,9];
B=[9,1];
C=[3,6;
   2,8;
   8,2;
   8,6];
r=[0.5;1;0.5;1];   
increment=0:0.005:1;
ButtonName = questdlg('Which search strategy should be used?', ...
                         'Search strategy selection', ...
                         'Discretization','Segmentation','Segmentation');

%% define  search settings
rng(202);
waypoint_num=7;
lb=zeros(waypoint_num,2);
ub=10*ones(waypoint_num,2);
for i=1:(round(waypoint_num/2)-2)
    ub(i,1)=4;
end
lb(round(waypoint_num/2)-1,:)=[4,4];
ub(round(waypoint_num/2)-1,:)=[4,6];
lb(round(waypoint_num/2),:)=[6,4];
ub(round(waypoint_num/2),:)=[6,6];
for i=round(waypoint_num/2)+1:waypoint_num
    lb(i,1)=6;
end

options = optimset( 'Display','Iter',...
                    'TolX',1e-6,...
                    'TolFun',1e-6,...
                    'MaxIter',500,...
                    'MAxfunEval',10000);

%% Define ranfom waypoints
P=zeros(waypoint_num,2);
for i=1:waypoint_num
    P(i,1)=lb(i,1) + (ub(i,1)-lb(i,1))*rand(1);
    P(i,2)=lb(i,2) + (ub(i,2)-lb(i,2))*rand(1);
end

%% Optimize
%P_opt=fmincon(@(P)objective(A,P,B),P,[],[],[],[],lb,ub,@(P)constraints(A,B,P,C,r),options);
P_opt=fmincon(@(P)objective(A,P,B),P,[],[],[],[],lb,ub,@(P)constraints(A,B,P,C,r,increment,ButtonName),options);

%% Plot
figure('Name','Solution','NumberTitle','off');
viscircles(C,r);
hold on
    % plot obstacles
    rectangle('Position',[4,0,2,4],'Facecolor','k')
    rectangle('Position',[4,6,2,4],'Facecolor','k')
    xlim([0,10]);
    ylim([0,10]);
    grid;
    Line=[A;P;B];
    l1=plot(Line(:,1),Line(:,2),'--b');
    Line=[100,110;120,130]; % just for legend
    l2=plot(Line(:,1),Line(:,2),'-b');
    legend([l1 l2],{'Random','Optimized'},'AutoUpdate','off');
    
    % set plot dimensions
    x0=30;
    y0=30;
    width=720;
    height=720;
    set(gcf,'units','points','position',[x0,y0,width,height])
    
    %plot stqrt/end points       
    Points=[A;P_opt;B];
    plot(A(1),A(2),'.r','MarkerSize',30);
    labels = {'A'};
    text(A(1),A(2),labels,'VerticalAlignment','top','HorizontalAlignment','right')
    plot(B(1),B(2),'.r','MarkerSize',30);
    labels = {'B'};
    text(B(1),B(2),labels,'VerticalAlignment','top','HorizontalAlignment','right')
    
    %Star video
    writerObj = VideoWriter('animated_output.avi'); 
    open(writerObj);
    writeObj.FrameRate = 60;
    F = getframe;
    writeVideo(writerObj,F);

    for i=1:length(Points)-1             % for every segment
        Pm=Points(i,:);
        if i~=1 && i~=(length(Points)-1) % plot intermediqte points
            plot(Pm(1),Pm(2),'.b','MarkerSize',25);
        end
        F = getframe;
        writeVideo(writerObj,F);
        
        for k=1:size(increment,2)       % plot lines
            Pm=Points(i,:)+(increment(k)*(Points(i+1,:)-Points(i,:)));
            plot(Pm(1),Pm(2),'.b','MarkerSize',4);
            F = getframe;
            writeVideo(writerObj,F);
        end
    end
    
    close(writerObj);
hold off

