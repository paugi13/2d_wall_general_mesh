function [T, Taux] = temp_field_calc(ap, ae, aw, an, as, bp, T, n, m)
% Here the iteration is executed.
% The initial temperatures vector is stored in an auxiliar vector si the
% error can be calculated to decide if the results are good or not.

Taux = T;

for j = 2:m+1
    for i = 2:n+1
        T(j,i) = (ae(j,i)*T(j,i+1) + aw(j,i)*T(j, i-1) + an(j,i)*T(j-1,i) ... 
            + as(j,i)*T(j+1,i) + bp(j,i))/ap(j,i);
    end
end

T(:,1) = (ae(:,1).*T(:,2) + bp(:,1))./ap(:,1);    % Left side.
T(1,:) = (as(1,:).*T(2,:) + bp(1,:))./ap(1,:);    % Upper side.
T(:,n+2) = (aw(:,n+2).*T(:, n+1)+ bp(:,n+2))./ap(:,n+2);    % Right side.
T(m+2,:) = (an(m+2,:).*T(m+1,:)+ bp(m+2,:))./ap(m+2,:);     % Lower side.