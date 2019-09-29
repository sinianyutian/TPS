function ip_img = nearestInterp(img, map, radius)
% 填补变形后空白位置像素，最邻近插值
% parameters：
%   - inputs:
%       - img: H*W*C, 变形后的图像
%       - map: H*W, mask图像，0-为空白位置，1-为有像素位置
%       - radius: 插值区域半径
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
        
        % 查找空白像素位置radius区域内的非空白像素
        for ii = 1 : radius
            % 从最小区域像外扩
            yU = max(y_idx - ii, 1);
            yD = min(y_idx + ii, H);
            xL = max(x_idx - ii, 1);
            xR = min(x_idx + ii, W);
            
            no_hole = 0;
            if ~isempty(find(map(yU:yD, xL:xR), 1))
                % 非空，有非空白像素
                no_hole = 1;
                break;
            end
        end
        
        % 填补空白
        if no_hole
            for c_idx = 1 : C
                block = img(yU:yD, xL:xR, c_idx);
                ip_img(y_idx, x_idx, c_idx) = median(block(map(yU:yD, xL:xR)>0)); % 使用邻域内非空白像素的中值填补，也可以使用均值
            end
        end
        
    end
end

end