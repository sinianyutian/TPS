function [img_warp, ip_img] = warpImage(img, warpedPoint, interp)
% 对图像进行变形
% parameters：
%   - inputs:
%       - img: H*W*C, 图像
%       - warpedPoint: 变换后对应的位置
%       - interp: 插值方法：0-最邻近，1-反距离加权插值
%   - outputs:
%       - img_warp: 变换后的图像
%       - ip_img: 插值后的图像
% 

% 图像相关
[H, W, C] = size(img);
[x, y] = meshgrid(1:W, 1:H); %???
x = x(:);
y = y(:);

% 控制点相关
x_warped = round(warpedPoint(:, 1));
y_warped = round(warpedPoint(:, 2));

% x_warped = x_warped - min(x_warped(:)) + 1;
% y_warped = y_warped - min(y_warped(:)) + 1;
x_warped = max(min(x_warped, W), 1);
y_warped = max(min(y_warped, H), 1);

% 对应的index
index = sub2ind([H, W], x, y); % 原始图像的index
index_warped = sub2ind([H, W], x_warped, y_warped); % warp后的index

% warp后的图像
img_warp = zeros(H, W, C);
o_c = zeros(H, W);
for c_idx = 1 : C
    img_c = img(:,:,c_idx); % 每个通道处理
    o_c(index_warped) = img_c(index);
    img_warp(:,:,c_idx) = o_c;
end

% 插值处理后图像
map = zeros(H, W);
map(index_warped) = 1;
if interp
    ip_img = idwInterp(img_warp, map, 2, 2);
else
    ip_img = nearestInterp(img_warp, map, 2);
end

end