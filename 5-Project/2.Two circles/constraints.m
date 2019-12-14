function [g,h]=constraints(A,B,P,C,r,increment)
h=[];
Points = [A; P; B];
g= zeros();
for i=1:length(Points)-1                % for every segment
    for j=1:size(r,1)                   % for every circle
    min_norm=101;
        for k=1:size(increment,2)       % find each discretized points
            Pm=Points(i,:)+(increment(k)*(Points(i+1,:)-Points(i,:)));
            min_norm= min(min_norm,norm(Pm-C(j,:)));
        end
        g(i,j)=r(j)-min_norm;
    end
end  

end