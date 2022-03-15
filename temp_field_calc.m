function [T, Taux] = temp_field_calc(ap, ae, aw, an, as, bp, T, n, m)
% Here the iteration is executed.
% The initial temperatures vector is stored in an auxiliar vector si the
% error can be calculated to decide if the results are good or not.

Taux = T;

for j = 2:m
    for i = 2:n
        T(j,i) = (ae(j,i)*T(j,i+1) + aw(j,i)*T(j, i-1) + an(j,i)*T(j+1,i) ... 
            + as(j,i)*T(j-1,i) + bp(j,i))/ap(j,i);
    end
end

T(:,1) = (ae(:,1).*T(:,2))./ap(:,1);
T(1,:) = (an(1,:).*T(2,:))./ap(1,:);
T(:,n+2) = (aw(:,n+2)*T(:, n+1)+ bp(:,n+2))/ap(:,n+2);
T(m+2,:) = (as(m+2,:).*T(m+1,:)+ bp(m+2,:))./ap(m+2,:);