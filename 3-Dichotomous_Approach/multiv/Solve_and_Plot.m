close all;
clear all;
clc;

% search settings
x_min=[15,0];
d=[-1,1.5];
gain=20;

%% define  search settings
rng(202);
options = optimset( 'Display','Iter',...
                    'TolX',1e-3,....
                    'MaxIter',500,...
                    'MaxfunEval',1000);

%% Optimize
X_opt=dich_multiv(x_min,d,gain,@(x)objective(x),options);

%plot range
x1=[-20:0.1:20];
x2=[-20:0.1:20];

%% Plot
[X1,X2]=meshgrid(x1,x2);
Z=zeros(size(X1));

for i=1:size(X1,1)
    for j=1:size(X2,2)
        Z(i,j)=objective([X1(i,j),X2(i,j)]);
    end
end

figure('Name','Contour','NumberTitle','off');
contour(X1,X2,Z,'ShowText','on')
hold on
xlim([x1(1),x1(end)]);
ylim([x2(1),x2(end)]);
X_opt=dich_multiv(x_min, d, gain,@(x)objective(x), options);
x_max=x_min+gain*d;
for i=1:size(X_opt,1)-1
        plot(X_opt(i,1),X_opt(i,2),'--*r');
end
plot(X_opt(size(X_opt,1),1),X_opt(size(X_opt,1),2),'*g');
hold off