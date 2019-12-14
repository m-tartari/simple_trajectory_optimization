function f=objective(A,P,B)
    Points=[A;P;B];
    f=zeros();
    for i=1:(length(Points)-1)
        f=f+norm(Points(i+1,:)-Points(i,:));
    end
end