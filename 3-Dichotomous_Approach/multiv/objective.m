function f=objective(x)
%    f=200 +7*(x(1)-5)^2 + 3*(x(2)-10)^2;
    f=x(1) - x(2) + 2*x(1)^2 + 2*x(2)*x(1) + x(2)^2;
end