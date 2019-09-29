function Z = U(r)
% 公式U：Z(x,y) = -U(r)= -r^2 * log(r^2) = -r^2 * 2 * log(r)
% r为2个点之前的距离

r_copy = r;
r_copy(r_copy==0) = realmin; % 防止log(0)出现

Z = r .^ 2 .* log(r_copy) * 2;

end