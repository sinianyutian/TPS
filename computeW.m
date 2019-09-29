function W = computeW(control_point_1, control_point_2)
% 计算参数W，control_point_1变形得到control_point_2
% parameters：
%   - inputs:
%       - control_point_1: n*2，控制点，n为控制点个数
%       - control_point_2: n*2，与control_point_1对应的控制点
%   - outputs:
%       - W: (n+3)*2, 包含文章中的a1，ax，ay
% 

cN = length(control_point_1); % 控制点个数

% 计算参数
K = computeK(control_point_1); % n * n，文章中的K
P = [ones(cN, 1), control_point_1(:, 1), control_point_1(:, 2)]; % n * 3，文章中的P
L = [K, P; P', zeros(3, 3)]; % (n+3) * (n+3)，文章中的L，L=[[K p]; [P' O]]

Y = [control_point_2(:, 1), control_point_2(:, 2); zeros(3, 2)]; % (n+3) * 2，文章的Y，Y=(V|0 0 0)'，V为控制点坐标
% W = inv(L) * Y;
W = L \ Y; % 文章中公式：inv(L)*Y = (W|a1 ax ay)'

end