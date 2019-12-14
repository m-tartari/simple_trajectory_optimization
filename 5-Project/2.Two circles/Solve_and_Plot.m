close all;
clear all;
clc;

%startopt.m

% search settings
A=[1,9];
B=[9,1];
C=[3,6;
   2,8;];
r=[0.5;1];   
increment=0:0.01:1;
P=[1,2;
    2,4;
    6,7;
    4,7;
    5,8];

%% define  search settings
waypoint_num=5;
lb=zeros(waypoint_num,2);
ub=10*ones(waypoint_num,2);

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
Points=[A;B;P;P_opt];
plot(Points(:,1),Points(:,2),'*k','MarkerSize',10);
labels = {'A','B','1','2','3','4','5','1','2','3','4','5'};
text(Points(:,1),Points(:,2),labels,'VerticalAlignment','top','HorizontalAlignment','right')
Line=[A;P;B];        l1=plot(Line(:,1),Line(:,2),'--b');
    Line=[A;P_opt;B];    l2=plot(Line(:,1),Line(:,2),'r');
    legend([l1 l2],{'Random','Optimized'});
viscircles(C,r)
hold off
