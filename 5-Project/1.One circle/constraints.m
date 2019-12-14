function [g,h]=constraints(X)
% [g,h]=constr(A,B,P1,C,r,increment)
%
% h              vector of equalitites
% g              vector of inequalities
%
% A              starting point
% B              end point
% P1             intermidiate point
% C              center of the circle
% r              radius
% increment      numebr of segment in which each line has been discretized

global A B C r;
h = [];
%initializing
minNorm = 0;
M=[A;X;B];
n = 0 :0.01:1;
normseg=zeros(length(n),2);
for i = 1 : 2  %for every segment
  for j = 1 : length(n) %for every discretized point
    Ps=M(i,:)+n(j)*(M(i+1,:) - M(i,:)); %discretized point
    normseg(j,i) = norm (Ps-C);  %distance between center and point
  end 
	minNorm(i) = min (normseg(:,i));  %find distance of the closest point
  	g(i)= r - minNorm(i);  %smallest distance must be higher then radius
end 