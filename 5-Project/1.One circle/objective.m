function f=objective(X)
global A B
    Points=[A;X;B];
    f=zeros();
    for i=1:(length(Points)-1)
        f=f+norm(Points(i+1,:)-Points(i,:));
    end
end