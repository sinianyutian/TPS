close all
clear
clc

point_x1 = [10, 11, 328, 328, 141, 141, 228, 228, 256, 52]';
point_y1 = [11, 329, 11, 330, 26, 113, 27, 112, 229, 258]';
point_x2 = [11, 11, 328, 328, 141, 141, 170, 170, 285, 83]';
point_y2 = [12, 330, 12, 329, 54, 85, 54, 84, 288, 227]';

% control_point: n*2，n为控制点个数，每个控制点为(x,y)
control_point_1 = [point_x1, point_y1];
control_point_2 = [point_x2, point_y2];

% 计算W
W = computeW(control_point_2, control_point_1);
test = 0;

% 计算变换后的位置:f(x',y') = a1 + ax * x + ay * y + SUM(wi * U(|Pi-(x,y)|))，i为每个控制点
warpedPoint = tpsMap(W, [340, 340], control_point_2);

% 对图像进行warp
img = imread('test.jpg');
% [img_warp, img_ip] = warpImage(img, warpedPoint, 1);
img_warp = warpImage1(img, warpedPoint);

% show
figure(1)

subplot(1,2,1); imshow(img,[]);
for ix = 1 : length(control_point_1)
	impoint(gca,control_point_1(ix, 2),control_point_1(ix, 1));
end

subplot(1,2,2); imshow(uint8(img_warp),[]);
for ix = 1 : length(control_point_1)
	h = impoint(gca,control_point_2(ix, 2),control_point_2(ix, 1));
    setColor(h,'r')
    impoint(gca,control_point_1(ix, 2),control_point_1(ix, 1));
    h1 = imline(gca, [control_point_1(ix, 2), control_point_2(ix, 2)], [control_point_1(ix, 1), control_point_2(ix, 1)]);
    setColor(h1,'g')
end


