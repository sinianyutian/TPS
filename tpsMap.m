function warpedPoint = tpsMap(cW, imgSize, control_point)
% 计算变换后的位置：f(x',y') = a1 + ax * x + ay * y + SUM(wi * U(|Pi-(x,y)|))，i为每个控制点
% parameters：
%   - inputs:
%       - cW: (n+3)*2, 变换系数
%       - imgSize: 2*1, (H, W), 图像大小
%       - control_point: n*2，控制点，n为控制点个数
%   - outputs:
%       - warpedPoint: H*W, 变换后对应的位置
% 

% 图像相关
H = imgSize(1);
W = imgSize(2);
HW = H * W;

[x, y] = meshgrid(1:W, 1:H); %???
x = x(:)'; % 转换成 1 * HW
y = y(:)';

% 控制点相关
cX = control_point(:, 1);
cY = control_point(:, 2);
cN = length(cX);

% 扩展，方便矩阵计算
x_rep = repmat(x, cN, 1); % 按控制点数扩展，每个点都要与所有控制点进行计算
y_rep = repmat(y, cN, 1);

cX_rep = repmat(cX, 1, HW); % 按图像大小扩展，每个控制点都要与所有像素进行计算
cY_rep = repmat(cY, 1, HW);

R = sqrt((cX_rep - x_rep) .^ 2 + (cY_rep - y_rep) .^ 2); % U(|Pi-(x,y)|)
K = U(R);
P = [ones(HW, 1), x', y']';
L = [K; P]';

warpedX = L * cW(:, 1);
warpedY = L * cW(:, 2);

warpedPoint = [warpedX, warpedY];

end