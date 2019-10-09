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
% img_interp = zeros(H, W, C);

% 控制点相关
x_warped = round(warpedPoint(:, 1));
y_warped = round(warpedPoint(:, 2));

x_warped = reshape(x_warped, [W, H])';
y_warped = reshape(y_warped, [W, H])';

% 得到变形后的图像
for row = 1 : H
    for col = 1 : W
        if (x_warped(row, col) >= 1 && x_warped(row, col) <= W) && (y_warped(row, col) >= 1 && y_warped(row, col) <= H)
            img_warp(row, col, :) = img(y_warped(row, col), x_warped(row, col), :);
        end
    end
end

% % 利用插值(双线性)，改善变形后的图像
% x = reshape(warpedPoint(:, 1), [W, H])';
% y = reshape(warpedPoint(:, 2), [W, H])';
% 
% % x(x < 2) = 2;
% % x(x > W-1) = W-1;
% x0 = fix(x);
% % y(y < 2) = 2;
% % y(y > H-1) = H-1;
% y0 = fix(y);
% dx = x - x0;
% dy = y - y0;
% 
% for row = 1 : H
%     for col = 1 : W
%         x_i = x0(row, col);
%         y_i = y0(row, col);
%         if (x_i > 1 && x_i < W) && (y_i > 1 && y_i < H)
%             for c_idx = 1 : C
%                 img_interp(row, col, c_idx) = img(y_i, x_i, c_idx) * (1 - dx(y_i, x_i)) * (1 - dy(y_i, x_i)) ...
%                                           + img(y_i, x_i + 1, c_idx) * dx(y_i, x_i) * (1 - dy(y_i, x_i)) ...
%                                           + img(y_i + 1, x_i, c_idx) * (1 - dx(y_i, x_i)) * dy(y_i, x_i) ...
%                                           + img(y_i + 1, x_i + 1, c_idx) * dx(y_i, x_i) * dy(y_i, x_i);
%             end
%         end
%     end
% end

end