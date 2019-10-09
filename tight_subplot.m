function pos = tight_subplot(Nh, Nw, gap, marg_h, marg_w)

% tight_subplot creates "subplot" axes with adjustable gaps and margins
%
% pos = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
%
%   in:  Nh      子图行数
%        Nw      子图列数
%        gap     子图间隔
%        marg_h  行边缘距离
%        marg_w  列边缘距离
%   out:
%       pos      元组，每个子图的位置，[left bottom width height]
%
% example:
% Nh = 2;
% Nw = 3;
% gap = 0.08;
% marg_h = 0.1;
% marg_w = 0.1;
% x = 0:pi/100:2*pi;
% y = sin(x);
% pos = tight_subplot(Nh, Nw, gap, marg_h, marg_w);
% subplot('Position', pos{1,1}), plot(x,y)
% subplot('Position', pos{1,2}), plot(x,y)
% subplot('Position', pos{1,3}), plot(x,y)
% subplot('Position', pos{2,1}), plot(x,y)
% subplot('Position', pos{2,2}), plot(x,y)
% subplot('Position', pos{2,3}), plot(x,y)
% 
% 注意：对于imshow()，效果不好！！！


h_step = (1 - 2 * marg_h - (Nh - 1) * gap) / Nh;
w_step = (1 - 2 * marg_w - (Nw - 1) * gap) / Nw;

pos = cell(Nh, Nw);
for row = 1 : Nh
    for col = 1 : Nw
        left = marg_w + (w_step + gap) * (col - 1);
        bottom = marg_h + (h_step + gap) * (Nh - row);
        pos{row, col} = [left, bottom, w_step, h_step];
    end
end

end