function [ g h ] = const1( X )
% g inequality constraint vector 
% h equality constraint vector 
h=[];
g(1)= 10*X(1)+ 5*X(2)- 2500;
g(2)= 4* X(1)+  10*X(2) - 2000;
g(3)= X(1)+1.5*X(2)-450;
g(4) = - X(1);
g(5) = - X(2);
end

