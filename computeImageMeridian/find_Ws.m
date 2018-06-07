clc

width = 1080;
height = 720;

%% load data
load('contour_line.mat');
load('../Data/f20_1080_720/20_1.mat');
load('../Data/f20_1080_720/L12_infty.mat');
load('../Data/f20_1080_720/L34_infty.mat');

abcdef_High=abcdef_High/abcdef_High(6);
a=abcdef_High(1);
b=abcdef_High(2);
c=abcdef_High(3);
d=abcdef_High(4);
e=abcdef_High(5);
f=abcdef_High(6);

%% 画椭圆
figure(1);
syms x;
syms y;
z1=a*y^2+b*x*y+c*x^2+d*y+e*x+f;
h1=ezplot(z1,[0,width,0,height]);
set(h1,'Color','k');
hold on;

%% 画无穷线
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

%% 画轮廓线-椎体
b_con=-1*contour_line(3)/contour_line(2); 
k_con=-1*contour_line(1)/contour_line(2);
x=0:0.1:width;
y = k_con*x+b_con;
plot(x,y,'b');
hold on

%% 画mu无穷
mu_infty=cross(L12_infty, contour_line);
%mu_infty = cross(L34_infty, contour_line);
mu_infty=mu_infty/mu_infty(3);
plot(mu_infty(1), mu_infty(2), '*r');
hold on


%% 过椭圆外一点求椭圆切线,并作图
ellipse=[a,b/2,d/2; b/2,c,e/2;d/2,e/2,f];
mu_line=ellipse*mu_infty;

syms x;
syms y;
digits(10);
z1=a*y^2+b*x*y+c*x^2+d*y+e*x+f;
z2=mu_line(1)*y+mu_line(2)*x+mu_line(3);
%z2=mu_line(1)*y+mu_line(2)*x+mu_line(3);
result=solve(z1,z2);
xx=result.x;
S_vpa_x = vpa(xx);
yy=result.y;
S_vpa_y = vpa(yy);
xxx=double(S_vpa_x);
yyy=double(S_vpa_y);
xk=[xxx,yyy];
x1=[xk(1,:),1]';
x2=[xk(2,:),1]';

plot(x1(1),x1(2),'ro');
plot(x2(1),x2(2),'ro');

k_tangent_1=(mu_infty(2) - x1(2))/(mu_infty(1)-x1(1));
k_tangent_2=(mu_infty(2) - x2(2))/(mu_infty(1)-x2(1));
x=0:0.1:width;
y_tangent_line_1 = k_tangent_1*(x-mu_infty(1))+mu_infty(2);
y_tangent_line_2 = k_tangent_2*(x-mu_infty(1))+mu_infty(2);
plot(x,	y_tangent_line_1 ,'c');
plot(x,	y_tangent_line_2 ,'m');
hold on;

% line_mu2ellipse_1_x = [mu_infty(1), x1(1)]';
% line_mu2ellipse_1_y = [mu_infty(2), x1(2)]';
% line(line_mu2ellipse_1_x, line_mu2ellipse_1_y);
% hold on
% 
% line_mu2ellipse_2_x = [mu_infty(1), x2(1)]';
% line_mu2ellipse_2_y = [mu_infty(2), x2(2)]';
% line(line_mu2ellipse_2_x,line_mu2ellipse_2_y);
% hold on

%% 显示调整
set(gca,'ydir','reverse');
axis equal;
axis([0 width 0 height]);
legend('ellipse High' , 'L 12', 'L 34','contour line', 'mu infty', '切点', '切点',  '切线1', '切线2');


% k_pole_polar=-mu_line(1)/mu_line(2);
% b_pole_polar=-mu_line(3)/mu_line(2); 
% x=0:0.1:width;
% y = k_pole_polar*x+b_pole_polar;
% plot(x,y,'c');
% hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% theta = 0.5*atan(b/(a-c));
% x_c = (b*e-2*c*d)/(4*a*c-b*2);
% y_c = (b*d-2*a*e)/(4*a*c-b*2);
% plot(x_c,y_c,'*')
% q = 64*(f*(4*a*c-b*b)-a*e*e+b*d*e-c*d*d)/((4*a*c-b*b)^2);
% s = 1/4*sqrt(abs(q)*sqrt(b*b-(a-c)^2));
% r_max = 1/8*sqrt(2*abs(q)*sqrt(b*b+(a-c)^2)-2*q*(a+c));
% r_min = sqrt(r_max^2-s^2);
% [slope, intercept] = tangentEllipse(mu_infty(1), mu_infty(2), x_c, y_c, r_max, r_min, theta);
% 
% k_tangent1=slope;
% b_tangent1=intercept; 
% x=0:0.1:width;
% y = k_tangent1*x+b_tangent1;
% plot(x,y,'r');


% syms k
% result=solve('(b*mu_infty(2) + d - b*mu_infty(1)*k + e*k + 2*k*c*(mu_infty(2)-k*mu_infty(1)))^2 - 4*(a+b*k+c*k^2) * (f+e*mu_infty(2)-e*mu_infty(1)*k+c*(mu_infty(2)-k*mu_infty(1))^2)=0','k');
% result=eval(result)
% 
% k=result(2); 
% x=0:0.1:width;
% y = k*(x-mu_infty(1)) + mu_infty(2);
% plot(x,y,'c');



% tt=vpa(result)
% mm = double(tt)
%xx = double(result)

%k=solve('(abcdef_High(2)*mu_infty(2)+abcdef_High(4)-abcdef_High(2)*mu_infty(1)*k+abcdef_High(5)*k+2*k(mu_infty(2)-k*mu_infty(1)))^2-4*(a+abcdef_High(2)*k+k^2)*(abcdef_High(6)+abcdef_High(5)*mu_infty(2)-abcdef_High(5)*mu_infty(1)*k+(mu_infty(2)-k*mu_infty(1))^2)=0','k');

% %%%%%%%%%%需要判断要哪个k即k的取值
% syms x y
% s=solve('y=k*(x-mu_infty(1))+mu_infty(2)','a*x^2 + abcdef_High(2)*x*y + abcdef_High(3)*y^2 + abcdef_High(4)*x + abcdef_High(5)*y + abcdef_High(6) = 0');
% s.x
% s.y

% m=double(s.x)
% n=double(s.y)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%过椭圆外一点求切线%%%%%%%%%%%%%%%%%%
% ellipse = [a,   b/2, d/2;  
%            b/2, c,   e/2;  
%            d/2, e/2, f];
% 
% ellipse = ellipse/ellipse(3,3);  
% plot(300, 10, '*');
% mu_line=[300 10 1]*ellipse;



% line_mu2ellipse_1_x = [mu_infty(1), x1(1)]';
% line_mu2ellipse_1_y = [mu_infty(2), x1(2)]';
% plot(line_mu2ellipse_1_x, line_mu2ellipse_1_y, 'c');
% 
% line_mu2ellipse_2_x = [mu_infty(1), x2(1)]';
% line_mu2ellipse_2_y = [mu_infty(2), x2(2)]';
% plot(line_mu2ellipse_2_x, line_mu2ellipse_2_y, 'm');



%mu_line=ellipse*mu_infty;



% %%极线
% %mu_line=mu_infty'*ellipse;
% mu_line=ellipse*mu_infty;
% mu_line=mu_line/mu_line(3);
% 

% k=-mu_line(1)/mu_line(2);
% b=-mu_line(3)/mu_line(2); 
% x=0:0.1:width;
% y = k*x+b;
% plot(x,y,'c');

%%极点
% syms x y
% s=solve(a*x^2+abcdef_High(2)*x*y+abcdef_High(3)*y^2+ ...
%     abcdef_High(4)*x+abcdef_High(5)*y+abcdef_High(6)==0, ...
%     mu_line(1)*x+mu_line(2)*y+mu_line(3)==0,x,y);
% X=double(s.x)
% Y=double(s.y)
% x1 = [X(1), Y(1)]
% x2 = [X(2), Y(2)]

% line_mu2ellipse_1_x = [mu_infty(1), x1(1)]';
% line_mu2ellipse_1_y = [mu_infty(2), x1(2)]';
% plot(line_mu2ellipse_1_x, line_mu2ellipse_1_y, 'c');
% 
% line_mu2ellipse_2_x = [mu_infty(1), x2(1)]';
% line_mu2ellipse_2_y = [mu_infty(2), x2(2)]';
% plot(line_mu2ellipse_2_x, line_mu2ellipse_2_y, 'm');
























