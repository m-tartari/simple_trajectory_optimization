clear all
close all 
clc
T= 1; 
Tf=0.05; 
x=15;
Xopt=x;
fxopt=my_fun(Xopt);
eps = 5;
Maxiter=10;
points = zeros (1, Maxiter);
Pa= zeros (1,Maxiter);
deltaE= zeros (1, Maxiter);
exa= zeros (1, Maxiter);
while T>Tf
    iter=0;
    while iter <Maxiter
        iter=iter+1;
        a=x-eps;
        y=2*eps.*rand(1,1) + a;
        Fy=my_fun(y); Fx= my_fun(x);
        E = Fy-Fx;
        deltaE(iter)=E;
        if E<0
            x=y;
            Xopt = x;
            points(iter)=x;
        else
            P=rand(1,1);
            Pa(iter)=P;
            exa(iter)= exp(-E/T);
            if P<exp(-E/T)
                x=y;
                Xopt = x;
                points(iter)=x;
            end
        end
    end
    factor = 0.9;
    T=T*factor;
end
lim=-20:0.1:20
plot (lim, my_fun(lim))
hold on
grid on
p1=plot(points, my_fun(points), 'g+')
p2=plot(Xopt, my_fun(Xopt), 'r+')
legend ([p1 p2], {'Path', 'Final result'}, 'AutoUpdate', 'off');
xlabel ( 'x')
ylabel('f(x)')
hold off
