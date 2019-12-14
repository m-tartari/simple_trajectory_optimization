close all;
clear all;
clc;

% search settings
A=-1;
B=5;

%% define  search settings
rng(202);
options = optimset( 'Display','Iter',...
                    'TolX',1e-1,....
                    'MaxIter',500,...
                    'MaxfunEval',1000);

%% Optimize
[P_opt,xstar,xmin,xmax]=dich(A,B,@(x)objective(x),options);

%% Plot
figure('Name','Solution','NumberTitle','off');
fplot(@(x)objective(x))
hold on
    xlim([-1,5]);
    ylim([-1,10]);
    grid;
    for i=1:length(xstar)
        plot(xstar(i),objective(xstar(i)),'.r');
    end
    plot(P_opt,objective(P_opt),'.g');
hold off

