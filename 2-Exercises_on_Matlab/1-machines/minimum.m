clear all
close all
X0=[50 60];
Lb=[0 0];
Ub=[500 500];
options= optimset('Display','Iter','TolX', 1e-6,'Tolfun', 1e-6,'MaxIter',500,'MaxFunEvals',1000);
P= fmincon('obj1', X0, [],[],[],[],Lb,Ub,'const1',options);
%% Ploting 

x= [Lb(1):0.5:Ub(1)]; y= [Lb(2):0.5:Ub(2)];
figure(1) ; clf ; figure (1); hold on
[X Y] = meshgrid (x,y); 
z=zeros(size(X));
 for i=1:size(X,1)
     for j= 1: size(Y,2)
         point=[X(i,j),Y(i,j)] ;
         z(i,j)=obj1(point);
     end
 end
P1 = contour(X,Y,z,'ShowText','on'); drawnow
%% ploting G1
X= -(5*Y- 2500)/10;
plot(X,Y)
axis([0 500 0 500])
text(100,300,'\leftarrow g1=0')

%% ploting G2
X=  -(10*Y - 2000)/4;
plot(X,Y)
text(250,100,'\leftarrow g2=0')

%% Ploting G3
X=-(1.5*Y-450);
plot(X,Y)
text(400,45,'\leftarrow g3=0')
%% Ploting the Optimal 
P2=plot (P(1) , P(2), 'r+');
xlabel('x')
ylabel('f(x)')
title('Contour Plot of the Objective function')
legend ([P2], { 'Optimal'});
hold off

