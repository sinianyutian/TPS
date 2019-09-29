function ip_img = idwInterp(img, map, radius, p)
% 填补变形后空白位置像素，反距离加权插值（Inverse Distance Weighted）
% parameters：
%   - inputs:
%       - img: H*W*C, 变形后的图像
%       - map: H*W, mask图像，0-为空白位置，1-为有像素位置
%       - radius: 插值区域半径
%       - p: 权值指数
%   - outputs:
%       - ip_img: H*W*C, 填补空白后的图像
% 

[H, W, C] = size(img);
ip_img = img;

[y_idxs, x_idxs] = find(map == 0);
if ~isempty(y_idxs)
    % 非空时，有空白位置，需要处理
    p_cnt = length(y_idxs); % 空位位置像素个数
    for idx = 1 : p_cnt
        y_idx = y_idxs(idx);
        x_idx = x_idxs(idx);
        
        yU = max(y_idx - radius, 1);
        yD = min(y_idx + radius, H);
        xL = max(x_idx - radius, 1);
        xR = min(x_idx + radius, W);

        % 填补空白
        block_map = map(yU:yD, xL:xR);
        if ~isempty(find(block_map, 1))
            % 非空，有非空白像素
            dist = computeWeight(block_map, x_idx-xL+1, y_idx-yU+1, p);
            for c_idx = 1 : C
                ip_img(y_idx, x_idx, c_idx) = idw(img(yU:yD, xL:xR, c_idx), block_map, dist);
            end
        end

    end
end

end

function dist = computeWeight(map, cx, cy, p)
% 计算距离
% parameters：
%   - inputs:
%       - map: H*W, map区域，用来得到大小
%       - cx: map中心位置x坐标，在图像边缘时，与map中心不重合
%       - cy: map中心位置y坐标，在图像边缘时，与map中心不重合
%       - p: 权值指数
%   - outputs:
%       - dist: H*W, 距离
% 

[h, w] = size(map);
[x, y] = meshgrid(1:w, 1:h); %???
X = (x - cx) .^ 2;
Y = (y - cy) .^ 2;
d2 = X + Y;

dist = 1 ./ (d2 .^ (p/2));

end

function pix = idw(img, map, dist)
% 计算加权后的像素值
% parameters：
%   - inputs:
%       - img: H*W, 图像区域
%       - map: 图像区域对应的空白mask
%       - dist: 每个点到中心的距离
%   - outputs:
%       - pix: 加权后的像素值
%

weight = sum(double(img(map > 0)) .* dist(map > 0));
total = sum(dist(map > 0));

pix = weight / total;

end