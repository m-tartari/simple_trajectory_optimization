function [g,h]=constraints(A,B,P_int,C,r,increment,method)
% [g,h]=constr(A,B,P1,C,r,increment)
%
% h              vector of equalitites
% g              vector of inequalities
%
% A              starting point
% B              end point
% P_int          intermidiate point
% C              center of the circle
% r              radius
% increment      numebr of segment in which each line has been discretized
% method         search strategy to be used, can be:
%                   - Segmentation
%                   - Discretization

h=[];
Points=[A;P_int;B];     %  segment S defined between P_i-P_(i+1)
switch method
    
  case 'Segmentation'
    g= zeros(); X_int=[0,0];P=[0,0];Q=[0,0];
    for i=1:length(Points)-1                        % for every segment
        Px=Points(i,1);
        Py=Points(i,2);
        Qx=Points(i+1,1);
        Qy=Points(i+1,2);
        P=[Px,Py];
        Q=[Qx,Qy];
        Vx=Px-Qx;
        Vy=Py-Qy;
        
        for j=1:size(r,1)                           % for every circle
            Cx=C(j,1);
            Cy=C(j,2);

            X_int(1)= Cx + ((Cy-Py)*Vx-(Cx-Px)*Vy) / (Vy^2 + Vx^2)*Vy;
            X_int(2)= Cy - ((Cy-Py)*Vx-(Cx-Px)*Vy) / (Vy^2 + Vx^2)*Vx;
                 
            dp=norm(X_int-P);             % distance from 1st segment point
            dq=norm(X_int-Q);             % distance from 2nd segment point
            ds=norm(P-Q);                 % segment lenght
            if((dp > ds) || (dq > ds))    % if X_int outside S use distance from closest segment point
                     g(i,j)=r(j) - min(norm(C(j,:)-P),norm(C(j,:)-Q));
            else
                     g(i,j)=r(j)- norm(C(j,:)-X_int);
            end
        end
    end    
    
%% with discretization
  case 'Discretization'
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
  otherwise 
    error("unknown resolution method selected");
end