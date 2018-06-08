clear;
clc;

width = 1080;
height = 720;

load('25_1_inv.mat');
load('25_2_inv.mat');
load('L12_infty.mat');
load('L34_infty.mat');
load('ls.mat');
load('w.mat');
load('tangent_p1.mat')
load('tangent_p2.mat')
load('contour_points_xy.mat');

abcdef_High=abcdef_High/abcdef_High(6);
a=abcdef_High(1);
b=abcdef_High(2);
c=abcdef_High(3);
d=abcdef_High(4);
e=abcdef_High(5);
f=abcdef_High(6);
ellipse = [a,b/2,d/2;b/2,c,e/2; d/2,e/2,f];

abcdef_Low=abcdef_Low/abcdef_Low(6);
a_=abcdef_Low(1);
b_=abcdef_Low(2);
c_=abcdef_Low(3);
d_=abcdef_Low(4);
e_=abcdef_Low(5);
f_=abcdef_Low(6);

%% 画椭圆
syms x y
figure(1);
z1=a*x^2+b*x*y+c*y^2+d*x+e*y+f;
z2=a_*x^2+b_*x*y+c_*y^2+d_*x+e_*y+f_;
h1=ezplot(z1,[0,width,0,height]);
set(h1,'Color','k');
hold on;
h2=ezplot(z2,[0,width,0,height]);
set(h2,'Color','g');
hold on; 

%% x_chi 切线根据情况2选一
x_chi=tangent_p1;
%x_chi=tangent_p2;
plot(x_chi(1), x_chi(2), 'r*');
hold on

%% l_infty
l_infty = L12_infty;
% l_infty = L34_infty;
b_l_infty=-1*l_infty(3)/l_infty(2); 
k_l_infty=-1*l_infty(1)/l_infty(2);
x=0:0.1:width;
y = k_l_infty*x+b_l_infty;
plot(x,y,'r');
hold on


%% m无穷
omega=w/w(3,3);
% x 无穷
x_infty = cross(cross(x_chi,ellipse\l_infty),l_infty);
x_infty = x_infty/x_infty(3)
%x_infty = cross(cross(x_chi,inv(ellipse)*l_infty),l_infty);
vt_infty = omega\l_infty;
vt_infty = vt_infty/vt_infty(3)
m_infty = cross(x_infty,vt_infty);
m_infty = m_infty/m_infty(3)

b_m_infty=-1*m_infty(3)/m_infty(2); 
k_m_infty=-1*m_infty(1)/m_infty(2);
x=0:0.1:width;
y = k_m_infty*x+b_m_infty;
plot(x,y,'g');
hold on

%% m无穷与IAC的交点，即I、J点
iac_a = omega(1,1);
iac_b = 2*omega(1,2);
iac_c = omega(2,2);
iac_d = 2*omega(1,3);
iac_e = 2*omega(2,3);
iac_f = omega(3,3);

syms x y
s=solve(iac_a*x^2+iac_b*x*y+iac_c*y^2+iac_d*x+iac_e*y+iac_f==0,m_infty(1)*x+m_infty(2)*y+m_infty(3)==0,x,y);
X=double(s.x);
Y=double(s.y);
intersection_p1 = [X(1),Y(1), 1]'
intersection_p2 = [X(2),Y(2), 1]'

%% 求解 alpha beta
intersection_p1 = intersection_p1/intersection_p1(2);
intersection_p2 = intersection_p2/intersection_p2(2);

alpha = real(intersection_p1(1));
beta = abs(imag(intersection_p1(1)));

%% Mr Mr^-T
Mr = [1.0/beta,   -alpha*(1/beta), 0;
      0,          1,               0;
      m_infty(1), m_infty(2),      1];
  
Mr_1_T = (inv(Mr))';

%% rectify
% 点修正
contour_points_xy = contour_points_xy';
tmp = ones(length(contour_points_xy),1);
contour_points_xy = [contour_points_xy tmp];
contour_points_rectified = contour_points_xy*Mr; 
% 绘图 contour_points_xy && contour_points_rectified
plot(contour_points_xy(:,1),contour_points_xy(:,2),'--b');
plot(contour_points_rectified(:,1),contour_points_rectified(:,2),'r');
% 对称轴修正
l_z = Mr_1_T*ls;
% 绘图 ls lz
b=-1/ls(2); 
k=-1*ls(1)/ls(2);
x=0:0.1:width;
y = k*x+b;
plot(x,y, '--b');
hold on

b=-1/l_z(2); 
k=-1*l_z(1)/l_z(2);
x=0:0.1:width;
y = k*x+b;
plot(x,y, 'r');
hold on

%% 距离
b=-1/l_z(2); 
k=-1*l_z(1)/l_z(2);
Q1 = [0,b]';
Q2 = [200,k*200+b]';
intersections = [];
for index=1:length(contour_points_rectified)
    syms x y
    s=solve(k*x+b==y,-1/k*x+1/k*contour_points_rectified(index,1)+contour_points_rectified(index,2)==y,x,y);
    X=double(s.x);
    Y=double(s.y);
    intersections(index,1)= X;
    intersections(index,2)= Y;
    r(index) = real(sqrt((X-contour_points_rectified(index,1))^2 + (Y-contour_points_rectified(index,2))^2));
    if(index==1)
        h_increase(index) =  0;
    else
        h_increase(index) = sqrt((X-intersections(index-1,1))^2 + (Y-intersections(index-1,2))^2);
    end
end
scatter(intersections(:,1),intersections(:,2),'b*');
scatter(contour_points_rectified(:,1),contour_points_rectified(:,2),'b*');
save r r
save h_increase h_increase
ratio = r(1)/r(end);

%% 显示旋转体


%% 显示调整
set(gca,'ydir','reverse');
axis equal;
axis([0 width 0 height]);
legend('reference ellipse','ellipse 2', 'x chi','L infty', 'm infty', 'imaged meridian', 'rectified imaged meridian', 'ls', 'rectified ls');

