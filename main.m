%% Program to solve 2D walls through Gauss-Seidel iteration method. 
% Suitable boundary conditions must be defined. 
% Firstly conductivity constants are defined as unvariable. 
% Left and lower walls are defined as adiabatic. 
% Discretitzation method: Centered nodes. 

clc
clear; close all;

% Cubic piece. 

L = 2;
W = 2;
H = 2;

%Lambda will be later defined as variable.
lambda = 70;
Text = 200;
alpha_ext = 100; 
Qv = 1000;

% Solver caractheristics
n = 100;
m = 100;
delta = 10^-6;
Tinic = 300;

%% Calculating coefficients ([W/K])
[ap,ae, aw, an, as, bp, node] = coefficient_calc(Text, alpha_ext, L, W, H, n , m, Qv, lambda);

%% Initiation
T = zeros(m+2, n+2);

%Line-by-line algorithm.
for j = 1:(m+2)
    for i = 1:(n+2)
        T(j, i) = Tinic;    
    end
end

boolean = true;
rep = 0;

while boolean == true
    [T, Taux] = temp_field_calc(ap, ae, aw, an, as, bp, T, n, m);
    [error] = error_calc(T, Taux, n, m);
    if max(error, [], 'all') < delta
        boolean = false;
    end
    rep = rep+1;
end

%% Postprocessing
%The heatmap's orientation as it treats the matrix differently. 
figure
pcolor(T);
caxis([200 205]);
colorbar
