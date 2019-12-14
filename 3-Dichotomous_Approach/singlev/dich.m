function [x_star,xstar,xmin,xmax]= dich(a, b, objective,options)
% xstar= dich(a, b, options)
%
% xstar      Local minimum
%
% a          Initial point, lower boundry
% b          Initial point, upper boundry
% objective  Objective function
% options    Search option, should contain:
% - TolX        Distance between 2 points used during evaluation
% - MaxIter     Marximum nubero of iterations
% - MaxFunEvals Marximum nubero of objective function call
  L=b-a;
  iter = 0; Evalfun = 0;
  
  xstar=zeros();
  xmin=zeros();
  xmax=zeros();
  xmin(1)=a;
  xmax(1)=b;
  
  while ((L > options.TolX) && (iter< options.MaxIter) && (Evalfun< options.MaxFunEvals)) 
      c1 = a + (L-options.TolX)/2;
      c2 = a + (L+options.TolX)/2;
      if objective(c1)<objective(c2)
          b = c2; 
      else
          a = c1;
      end
      L=b-a;
      Evalfun = Evalfun+2;
      iter = iter+1;
      xstar(iter) =a + L/2;
      xmin(iter+1)=a;
      xmax(iter+1)=b;
  end
  x_star = a + L/2;
end