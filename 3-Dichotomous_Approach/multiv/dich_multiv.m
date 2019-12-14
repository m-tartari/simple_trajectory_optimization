function xstar= dich_multiv(xmin, d, gain,objective, options)
% xstar= dich_multiv(xmin, d, gain, options)
%
% xstar    Local minimum
%
% d        Direction of line upon which the minimum should be found
% gain     Distance metween the 2 starting points
% options  search option, should contain:
% - TolX        Distance between 2 points used during evaluation
% - MaxIter     Marximum nubero of iterations
% - MaxFunEvals Marximum nubero of objective function call

    xmax=xmin+gain*d;
    L=norm(xmax-xmin);
    
    x_min=xmin;
    x_max=xmax;
    iter = 0; Evalfun = 0;
    xstar=xmin + d*L/2;
    while ((L > options.TolX) && (iter< options.MaxIter) && (Evalfun< options.MaxFunEvals)) 
        x1 = xmin + d*(L-options.TolX)/2;
        x2 = xmin + d*(L+options.TolX)/2;
        if objective(x1)<objective(x2)
            xmax = x2;
        else
            xmin = x1;
        end
        L=norm(xmax-xmin);
        d=(xmax-xmin)/L;
        xstar=[xstar;xmin + d*L/2];
        Evalfun = Evalfun+2;
        iter = iter+1;
    end
    xstar=[xstar;xmin + d*L/2];
end