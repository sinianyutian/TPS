### Principal Warps: Thin-Plate Splines and the Decomposition of Deformations

___

参考文章及网上资料，实现TPS。



#### 代码说明

| 文件名          | 作用                                                         |
| --------------- | ------------------------------------------------------------ |
| computeK.m      | 计算文章中`K`                                                |
| computeW.m      | 计算文章的`W`，用于对图像变形的参数                          |
| U.m             | 文章中的公式：$U(r)=r^2log(r^2)$                             |
| show_U.m        | 显示U函数                                                    |
| idwInterp.m     | 反距离加权插值（Inverse Distance Weighted），解决hole问题    |
| nearestInterp.m | 最邻近插值，解决hole问题                                     |
| tpsMap.m        | 计算变形后的位置，利用了公式：<br>$f(x',y')=a_1+a_xx+a_yy+\sum_{i=1}^n{w_iU(\|P_i-(x,y)\|)}$ |
| warpImage.m     | 对图像进行变形，得到变形的图像                               |
| warpImage1.m    | 对图像进行变形，得到变形的图像(另外一种方法)                 |
| main.m          | 主函数                                                       |
| main_1.m        | 主函数(另外一种方法)                                         |



#### 代码运行

执行 `main.m` 或者`main_1.m`



#### 示例

![main方法结果](https://github.com/yfor1008/TPS/raw/master/src/main_result.png)

![main_1方法结果](https://github.com/yfor1008/TPS/raw/master/src/main_1_result.png)

说明：

- 蓝色为参考控制点，红色为目标控制点；
- main方法：直接计算蓝色控制点到红色控制点的变换，由于存在多对一的关系，从图中可以看到变换后会存在较多的hole，因而需要进行插值填补；
- main_1方法：采用反向映射，目标图像中的每一个像素点，都可以在参考图像中找到唯一对应的点，这样就可以使得目标图像不会存在hole，即计算红色控制点到蓝色控制点的变换；
- 对于main_1方法，同样会存在多对一的关系，会使得结果较差，如图所示；



#### 参考

1. https://blog.csdn.net/iverson_49/article/details/38160081
2. https://blog.csdn.net/kill201115/article/details/77575074
3. https://profs.etsmtl.ca/hlombaert/thinplates/#eq:thinplates
4. https://ww2.mathworks.cn/matlabcentral/fileexchange/24315-warping-using-thin-plate-splines