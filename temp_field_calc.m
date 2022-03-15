function [T, Taux] = temp_field_calc(ap,ae, aw, bp, T, n, Twall)
% Here the iteration is executed.
% The initial temperatures vector is stored in an auxiliar vector si the
% error can be calculated to decide if the results are good or not.

Taux = T;

T(1) = Twall;

for i = 2:n
    T(i) = (ae(i)*T(i+1) + aw(i)*T(i-1)+bp(i))/ap(i);
end

T(n+1) = (aw(n+1)*T(n)+bp(n+1))/ap(n+1);