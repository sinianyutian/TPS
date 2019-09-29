function [img_warp] = warpImage1(img, warpedPoint)

% 对图像进行变形
% parameters：
%   - inputs:
%       - img: H*W*C, 图像
%       - warpedPoint: 变换后对应的位置
%   - outputs:
%       - img_warp: 变换后的图像
%       - ip_img: 插值后的图像
% 

% 图像相关
[H, W, C] = size(img);

img_warp = zeros(H, W, C);

% 控制点相关
x_warped = round(warpedPoint(:, 1));
y_warped = round(warpedPoint(:, 2));

x_warped = reshape(x_warped, [W, H])';
y_warped = reshape(y_warped, [W, H])';

for row = 1 : H
    for col = 1 : W
        if (x_warped(row, col) >=1 && x_warped(row, col) <= W) && (y_warped(row, col) >=1 && y_warped(row, col) <= H)
            img_warp(row, col, :) = img(y_warped(row, col), x_warped(row, col), :);
        end
    end
end

end