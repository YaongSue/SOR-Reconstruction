clc

width = 1080;
height = 720;

%% load data
load('contour_line.mat');
load('../Data/f25_1080_720/25_1_inv.mat');
load('../Data/f25_1080_720/25_2_inv.mat');
load('../Data/f25_1080_720/L12_infty.mat');
load('../Data/f25_1080_720/L34_infty.mat');

abcdef_High=abcdef_High/abcdef_High(6);
a=abcdef_High(1);
b=abcdef_High(2);
c=abcdef_High(3);
d=abcdef_High(4);
e=abcdef_High(5);
f=abcdef_High(6);

abcdef_Low=abcdef_Low/abcdef_Low(6);
a_=abcdef_Low(1);
b_=abcdef_Low(2);
c_=abcdef_Low(3);
d_=abcdef_Low(4);
e_=abcdef_Low(5);
f_=abcdef_Low(6);

%% ����Բ
syms x y;
figure(1);
z1=a*x^2+b*x*y+c*y^2+d*x+e*y+f;
z2=a_*x^2+b_*x*y+c_*y^2+d_*x+e_*y+f_;
h1=ezplot(z1,[0,width,0,height]);
set(h1,'Color','k');
hold on;
h2=ezplot(z2,[0,width,0,height]);
set(h2,'Color','k');


%% ��������
b_v1=-1*L12_infty(3)/L12_infty(2); 
k_v1=-1*L12_infty(1)/L12_infty(2);
x=0:0.1:width;
y = k_v1*x+b_v1;
plot(x,y,'r');
hold on

b_v2=-1*L34_infty(3)/L34_infty(2); 
k_v2=-1*L34_infty(1)/L34_infty(2);
x=0:0.1:width;
y = k_v2*x+b_v2;
plot(x,y,'g');
hold on;

%% ��������-׵��
b_con=-1*contour_line(3)/contour_line(2); 
k_con=-1*contour_line(1)/contour_line(2);
x=0:0.1:width;
y = k_con*x+b_con;
plot(x,y,'b');
hold on

%% ��mu����
mu_infty=cross(L12_infty, contour_line);
%mu_infty = cross(L34_infty, contour_line);
mu_infty=mu_infty/mu_infty(3);
plot(mu_infty(1), mu_infty(2), '*r');
hold on

%% ����Բ��һ�������Բ����, �伫Լ����
% ����Բ��һ��ļ���
ellipse=[a,b/2,d/2; b/2,c,e/2;d/2,e/2,f];
mu_line=ellipse*mu_infty;
k_pole_polar=-mu_line(1)/mu_line(2);
b_pole_polar=-mu_line(3)/mu_line(2); 
x=0:0.1:width;
y = k_pole_polar*x+b_pole_polar;
plot(x,y,'c');
hold on

% ����Բ�뼫�ߵĽ�,���е�
syms x y
s=solve(a*x^2+b*x*y+c*y^2+d*x+e*y+f==0,mu_line(1)*x+mu_line(2)*y+mu_line(3)==0,x,y);
X=double(s.x);
Y=double(s.y);
tangent_p1 = [X(1),Y(1), 1]';
tangent_p2 = [X(2),Y(2), 1]';
scatter(X,Y,'ro');
save tangent_p1 tangent_p1;
save tangent_p2 tangent_p2;

% ������
plot([mu_infty(1), tangent_p1(1)]',[mu_infty(2), tangent_p1(2)]','--r');
hold on
plot([mu_infty(1), tangent_p2(1)]',[mu_infty(2), tangent_p2(2)]','--m');
hold on

%% ����Բ��һ�������Բ����, ����Բ�������̷�
% % �޸Ľű�����legend�������ʾ
% ellipse=[a,b/2,d/2; b/2,c,e/2;d/2,e/2,f];
% 
% % ��x��н�
% theta = 0.5*atan(b/(c-a));
% % ����
% x_c = (b*e-2*c*d)/(4*a*c-b^2);
% y_c = (b*d-2*a*e)/(4*a*c-b^2);
% 
% plot(x_c,y_c,'*');
% hold on
% 
% q = 64*(f*(4*a*c-b*b)-a*e*e+b*d*e-c*d*d)/((4*a*c-b*b)^2);
% s = 1/4*sqrt(abs(q)*sqrt(b*b+(a-c)^2));
% % ���̰���
% r_max = 1/8*sqrt(2*abs(q)*sqrt(b*b+(a-c)^2)-2*q*(a+c));
% r_min = sqrt(r_max^2-s^2);
% 
% [slope, intercept] = tangentEllipse(mu_infty(1), mu_infty(2), x_c, y_c, r_max, r_min, theta);
% k_tangent1=slope;
% b_tangent1=intercept; 
% x=0:0.1:width;
% y = k_tangent1*x+b_tangent1;
% plot(x,y,'r');

%% �������ϵĵ�
% �������Բ�е㣬������Բ���е�ֱ�ߵ��е�
ellipse_=[a_,b_/2,d_/2; b_/2,c_,e_/2;d_/2,e_/2,f_];
tangent_p1_line_=ellipse_*tangent_p1;
syms x y
s=solve(a_*x^2+b_*x*y+c_*y^2+d_*x+e_*y+f_==0,tangent_p1_line_(1)*x+tangent_p1_line_(2)*y+tangent_p1_line_(3)==0,x,y);
X_=double(s.x);
Y_=double(s.y);
tangent_p1_ = [X_(1),Y_(1), 1]';
tangent_p2_ = [X_(2),Y_(2), 1]';
plot(tangent_p1_(1),tangent_p1_(2),'ro');
plot(tangent_p2_(1),tangent_p2_(2),'ro');
% ���������ϵ����ɲ�����
k = (tangent_p1(2) -tangent_p1_(2))/(tangent_p1(1) -tangent_p1_(1));
if (tangent_p1(1) <= tangent_p1_(1))
    contour_points_x = tangent_p1(1):1:tangent_p1_(1);
else
    contour_points_x = tangent_p1_(1):1:tangent_p1(1);
end
contour_points_y = k*(contour_points_x-tangent_p1_(1))+tangent_p1_(2);
scatter(contour_points_x,contour_points_y,'*');
contour_points_x = [contour_points_x tangent_p1_(1)];
contour_points_y = [contour_points_y tangent_p1_(2)];
contour_points_xy = [contour_points_x; contour_points_y];
save contour_points_xy contour_points_xy;

%% ��ʾ����
set(gca,'ydir','reverse');
axis equal;
axis([0 width -height height]);
% �伫Լ����
legend('ellipse High', 'ellipse Low', 'L 12', 'L 34','contour line', 'mu infty', '����', '�е�', '����1','����2', '�е�', '�е�','������');
% ������
%legend('ellipse High' , 'L 12', 'L 34','contour line', 'mu infty', '��Բ����', '����');




























