clear all
close all 
clc
T= 1; 
Tf=0.05; 
x=[-5,-10];
Xopt=x;
fxopt=my_fun(Xopt(1), Xopt(2));
eps = 0.6;
Maxiter=100;
points = zeros (2, Maxiter);
while T>Tf
    iter=0;
    while iter <Maxiter
        iter=iter+1;
        a=x-eps*ones(1,2);
        y(1)=2*eps.*rand(1,1) + a(1);
        y(2)=2*eps.*rand(1,1) + a(2);
        Fy=my_fun(y(1),y(2)); Fx= my_fun(x(1),x(2));
        E = Fy-Fx;
        if E<0
            x=y;
            xout = x;
            points(1,iter)=xout(1);
            points(2,iter)=xout(2);
        else
            P=rand(1,1);
            if P<exp(-E/T)
                x=y;
                xout =x;
                points(1,iter)=xout(1);
                points(2,iter)=xout(2);
            end
        end
    end
    factor = 0.8;
    T=T*factor;
end
lb = [-20 -20]; ub =[20 20] ;
x= [lb(1):0.1:ub(1)]; y= [lb(2):0.1:ub(2)];
figure(1) ; clf ; figure (1); hold on
[X Y] = meshgrid (x,y); 
z=zeros(size(X));
 for i=1:size(X,1)
     for j= 1: size(Y,2)
         z(i,j)=my_fun(X(i,j),Y(i,j));
     end
 end
contour(X,Y,z); drawnow
for i = 1:1:Maxiter
P1=plot (points(1,i) , points(2,i), 'g+')
end
P2=plot (xout(1), xout(2),'r+')
legend ([P1 P2], {'Path', 'Final result'}, 'AutoUpdate', 'off');
hold off
