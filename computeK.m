function K = computeK(control_point)
% 计算参数K
% parameters：
%   - inputs:
%       - control_point: n*2，控制点，n为控制点个数
%   - outputs:
%       - K: n*n, 
%

cX = control_point(:, 1);
cY = control_point(:, 2);

cN = length(cX); % 控制点个数

% 扩展成矩阵，方便计算
cX_rep = repmat(cX, 1, cN);
cY_rep = repmat(cY, 1, cN);

% 计算距离，文章中公式 rij=|Pi-Pj|
R = sqrt((cX_rep - cX_rep') .^ 2 + (cY_rep - cY_rep') .^ 2);

% U变换，文章中公式 U(r)=r^2 * log(r^2)
K = U(R);

end