close all
clear
clc

[dx, dy] = meshgrid(-10:0.1:10);

r = sqrt(dx .^ 2 + dy .^ 2);
r_copy = r;
r_copy(r_copy==0) = realmin; % 防止log(0)出现

z = r .^ 2 .* log(r_copy) * 2;
% plot3(dx,dy,z)
mesh(dx, dy, z)




