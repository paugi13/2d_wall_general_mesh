function [error] = error_calc(T, Taux, n, m)
%The error vector is returned

error = zeros(n+1,1);

for j = 1:(m+2)
    for i = 1:(n+2)
        error(i) = abs(T(j,i)-Taux(j,i));
    end
end

