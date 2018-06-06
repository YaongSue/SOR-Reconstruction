### Ellipse_fitting
- fitting ellipse from image with ransac.
- input : image contain ellipse like in ```Data/f25_1080_720/f25_xia.pn```
- output : is the coefficience of  ax^2 + bxy + cy^2 +dx + ey + f = 0
- Usage
  ```matlab
  abcdef_High =  fit_Ellipse_From_Image('../Data/f25_1080_720/f25_shang.png')
  abcdef_Low =  fit_Ellipse_From_Image('../Data/f25_1080_720/f25_xia.png')
  ```

### find Fixed Entities and Camera Calibration
##### find Fixed Entities
- 输入 : 椭圆拟合得到的两个系数矩阵`abcdef_Low`和`abcdef_High`
- 输出 :
  1. 对称轴 : ls
  2. 无穷远点 : v_infty
  3. 无穷远直线 : L12_infty 或 L34_infty 需要根据判定条件选择
  4. 虚圆点 : I、J分别是点x1_I与X1_J或是点x2_I与X2_J
- Usage
更改`find_fixed_entities.m`中，修改如下代码中的变量为椭圆拟合得到的椭圆系数矩阵
  ```matlab
  load('30_1.mat');
  load('30_2.mat');
  ```
##### 假设主点处在相片中心且fx=fy求内参
- Usage
直接运行`calibration_with_principalpoint.m`,