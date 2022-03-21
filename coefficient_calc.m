function [ap,ae, aw, an, as, bp, node] = coefficient_calc(Text, alpha_ext, L, W, H, n , m, Qv, lambda)
% Function to calculate all the coefficients through the fin.
% They are returned in vector format.

ap = zeros(m+2, n+2);
aw = zeros(m+2, n+2);
ae = zeros(m+2, n+2);
an = zeros(m+2, n+2);
as = zeros(m+2, n+2);
bp = zeros(m+2, n+2);
node = zeros(m+2, n+2);

qv = Qv/(L*W*H);

% Calculating coefficients ([W/K])
% Boundary counditions may be required for nodes on limits.
% 
% node(:,1) = 0;
% node(1,:) = 0;
% node(m+2, :) = H;
% node(:, n+2) = L;

inc_y = H/m;
inc_x = L/n;
pos_x = inc_x/2;
pos_y = inc_y/2;

for j = 2:(m+1)
    for i=2:(n+1)
       pos_x = pos_x + inc_x; 
%        node(j,i) = [pos_x pos_y];
       Sw = inc_y*W;
       Se = inc_y*W;
       Sn = inc_x*W;
       Ss = inc_x*W;
       dpw = inc_x;
       dpe = inc_x;
       dpn = inc_y;
       dps = inc_y;

       aw(j,i) = lambda*Sw/dpw;
       ae(j,i) = lambda*Se/dpe;
       an(j,i) = lambda*Sn/dpn;
       as(j,i) = lambda*Ss/dps;
       ap(j,i) = aw(j,i) + ae(j,i)+ an(j,i)+ as(j,i);
       bp(j,i) = qv*(inc_x*inc_y*W);     
    end
    pos_x = inc_x/2;
    pos_y = pos_y + inc_y;
end

%Boundary conditions that can be adapted to other types of pieces. 
%Left side (adiabatic)
ap(:, 1) = 1;
ae(:, 1) = 1;
an(:, 1) = 0;
as(:, 1) = 0;
aw(:, 1) = 0;
bp(:, 1) = 0;

%Lower side (adiabatic) 
ap(m+2, :) = 1;
ae(m+2, :) = 0;
an(m+2, :) = 1;
as(m+2, :) = 0;
aw(m+2, :) = 0;
bp(m+2, :) = 0;

%Right side
ae(:, n+2) = 0;
an(:, n+2) = 0;
as(:, n+2) = 0;
aw(:, n+2) = lambda/(inc_x/2);
bp(:, n+2) = alpha_ext*Text;
ap(:, n+2) = aw(:, n+2)+alpha_ext;

%Upper side
ae(1, :) = 0;
an(1, :) = 0;
as(1, :) = lambda/(inc_y/2);
aw(1, :) = 0;
bp(1, :) = alpha_ext*Text;
ap(1, :) = as(1, :)+alpha_ext;


end

