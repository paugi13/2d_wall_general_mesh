function [error] = error_calc(T, Taux, n, m)
%The error vector is returned

error = zeros(m+2,n+2);

for j = 1:(m+2)
    for i = 1:(n+2)
        error(j,i) = abs(T(j,i)-Taux(j,i));
    end
end

