clear all
X0=[5 7];
Lb=[-20 -20];
Ub=[20 20];
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
%% ploting G1

X= sqrt(100 -(Y-10)^2)-5;
plot(X,Y)
axis([-20 20 -20 20])
text(-5,-10,'\leftarrow g1=0')

%% ploting G2
 X = sqrt(100- Y^2 ) +5;
 plot(X,Y)
 text(15,-15,'\leftarrow g2=0')


%% Ploting the Optimal 
P2=plot (P(1) , P(2), 'r*');
xlabel('x')
ylabel('f(x)')
title('Contour Plot of the Objective function')
legend ([P2], { 'Optimal'});
hold off
