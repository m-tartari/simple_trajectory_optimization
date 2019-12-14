clear all
close all
X0=[5 1];
Lb=[0 0];
Ub=[100 45];
options= optimset('Display','Iter','TolX', 1e-6,'Tolfun', 1e-6,'MaxIter',500,'MaxFunEvals',1000);
P= fmincon('obj1', X0, [],[],[],[],Lb,Ub,'const1',options);
%% Ploting 

x= [Lb(1):0.1:Ub(1)]; y= [Lb(2):0.1:Ub(2)];
figure(1) ; clf ; figure (1); hold on
[X Y] = meshgrid (x,y); 
z=zeros(size(X));
 for i=1:size(X,1)
     for j= 1: size(Y,2)
         point=[X(i,j),Y(i,j)] ;
         z(i,j)=obj1(point);
     end
 end
contour(X,Y,z); drawnow
% for i = 1:1:Maxiter
%% ploting G1
X= -(Y - 100)/2;
plot(X,Y)
axis([0 100 0 45])
text(40,20,'\leftarrow g1')

%% ploting G2
X=  -(Y - 80);
plot(X,Y)
text(60,20,'\leftarrow g2')

%% Ploting G3
line([0 100],[40 40],'LineWidth',0.1)
text(20,40,'\uparrow g3')
%% Ploting the Optimal 
P2=plot (P(1) , P(2), 'r*');
xlabel('x')
ylabel('f(x)')
title('Contour Plot of the Objective function')
legend ([P2], { 'Optimal'});
hold off

