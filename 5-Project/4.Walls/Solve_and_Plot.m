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
increment=0:0.01:1;
P=[1,2;
    2,4;
    6,7;
    4,7;
    4,6;
    5,6;
    8,9];

%% define  search settings
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


%% Optimize
P_opt=fmincon(@(P)objective(A,P,B),P,[],[],[],[],lb,ub,@(P)constraints(A,B,P,C,r,increment),options);

%% Plot
figure('Name','Solution','NumberTitle','off');
hold on
axis square;
     xlim([0,10]);
     ylim([0,10]); grid on
rectangle('Position',[4,0,2,4],'Facecolor','g')
rectangle('Position',[4,6,2,4],'Facecolor','g')
Points=[A;B;P;P_opt];
plot(Points(:,1),Points(:,2),'*k','MarkerSize',10);
labels = {'A','B','1','2','3','4','5','6','7','1','2','3','4','5','6','7'};
text(Points(:,1),Points(:,2),labels,'VerticalAlignment','top','HorizontalAlignment','right')
Line=[A;P;B];        l1=plot(Line(:,1),Line(:,2),'--b');
    Line=[A;P_opt;B];    l2=plot(Line(:,1),Line(:,2),'r');
    legend([l1 l2],{'Random','Optimized'});
viscircles(C,r)
hold off
