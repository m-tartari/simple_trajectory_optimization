function [g,h] = const1(X)
% g inequality constraint vector 
% h equality constraint vector 
h=[];
g(1)= 2*X(1)+ X(2)- 100;
g(2)=X(1)+  X(2) - 80;
g(3)= X(2)-40;
g(4) = - X(1);
g(5) = - X(2);
end

