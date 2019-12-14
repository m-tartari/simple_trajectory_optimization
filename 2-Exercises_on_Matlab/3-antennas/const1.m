function [ g h ] = const1( X )
% g inequality constraint vector 
% h equality constraint vector 
h=[];
g(1)= 10-sqrt((X(1)+ 5)^2 + (X(2)-10)^2);
g(2)= 10-sqrt((X(1)- 5)^2 + X(2)^2);
end

