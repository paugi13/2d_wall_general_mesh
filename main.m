%% Program to solve heat transfer problems in circular fins through finite difference method.
% In this case iterations are made using the Gauss - Seidel Method. 
% The circular fin in this problem is around a circular pipe carrying some gas. 

% Physical inputs.
% Adiabatic end is not assumed.
clc
clear; close all;
Rint = 1;
Rext = 2;
ef = 0.05;

lambda = 70;
Twall = 400;
Text = 200;
alpha_ext = 100; 
alpha_end = 100;

% Solver caractheristics

n = 100;
delta = 10^-6;
Tinic = 700;

%% Calculating coefficients ([W/K])
[ap,ae, aw, bp, node] = coefficient_calc(Rext,Rint,lambda,n, ef, alpha_ext, Text, alpha_end, Twall);

%% Initiation
T = zeros(n+1,1);

for i =1:(n+1)
    T(i) = Tinic;    
end
boolean = true;
rep = 0;

while boolean == true
    [T, Taux] = temp_field_calc(ap,ae, aw, bp, T, n, Twall);
    [error] = error_calc(T, Taux, n);
    if max(error) < delta
        boolean = false;
    end
    rep = rep+1;
end


%Postprocessing
text_line = 0:0.5:Rext;
Text_vec = zeros(size(text_line,2), 1);
for i = 1:size(Text_vec,1)
   Text_vec(i) = Text;
end
figure
plot(node, T, 'r');
xlabel('r [m]');
ylabel('T [K]');
title('Temperature along the circular fin');
grid on

hold on
plot(text_line, Text_vec, 'black');
hold off
