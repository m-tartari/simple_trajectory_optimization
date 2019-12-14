%% clean workspace
close all; clear all; clc;

%% search settings
global A B C r
A=[1,9];
B=[9,1];
C=[5, 5];
r=1; 

X=[1,8];
lb=[0,0];
ub=[10,10];

options = optimset( 'Display','Iter',...
                    'TolX',1e-6,...
                    'TolFun',1e-6,...
                    'MaxIter',500,...
                    'MAxfunEval',10000);

%% Optimize
P_opt=fmincon(@(P)objective(P),X,[],[],[],[],lb,ub,@(P)constraints(P),options);

%% Plot

figure('Name','Solution','NumberTitle','off');
hold on
axis square;
     xlim([0,10]);
     ylim([0,10]); grid on
Points=[A;B;X;P_opt];
plot(Points(:,1),Points(:,2),'*k','MarkerSize',10);
labels = {'A','B','1','1'};
text(Points(:,1),Points(:,2),labels,'VerticalAlignment','top','HorizontalAlignment','right')
Line=[A;X;B];        l1=plot(Line(:,1),Line(:,2),'--b');
    Line=[A;P_opt;B];    l2=plot(Line(:,1),Line(:,2),'r');
    legend([l1 l2],{'Random','Optimized'});
viscircles(C,r)
hold off