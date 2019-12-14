function [f] = my_fun(x,y)  
  f = -20*exp(-0.2*sqrt(0.5*(x^2 + (y^2))))- exp(0.5*(cos(x*2*pi)+cos(y*2*pi)))+20+exp(1);
end 

