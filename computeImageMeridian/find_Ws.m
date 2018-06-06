clc

width = 1080;
height = 720;

load('contour_line.mat');
load('../Data/f25_1080_720/25_1.mat');
load('../Fixed_entities+Camera_calibration/L12_infty.mat');
load('../Fixed_entities+Camera_calibration/L34_infty.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画椭圆%%%%%%%%%%%%%%%%%%%%
figure(1);
syms x;
syms y;
z1=abcdef_High(1)*y^2+abcdef_High(2)*x*y+abcdef_High(3)*x^2+abcdef_High(4)*y+abcdef_High(5)*x+abcdef_High(6);
h1=ezplot(z1,[0,width,-height,height]);
set(h1,'Color','k');
hold on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画无穷线%%%%%%%%%%%%%%%%%%%%
b=-1*L12_infty(3)/L12_infty(2); 
k=-1*L12_infty(1)/L12_infty(2);
x=0:0.1:width;
y = k*x+b;
plot(x,y,'r');
hold on

b=-1*L34_infty(3)/L34_infty(2); 
k=-1*L34_infty(1)/L34_infty(2);
x=0:0.1:width;
y = k*x+b;
plot(x,y,'g');
hold on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画轮廓线-椎体%%%%%%%%%%%%%%
b=-1*contour_line(3)/contour_line(2); 
k=-1*contour_line(1)/contour_line(2);
x=0:0.1:width;
y = k*x+b;
plot(x,y,'b');
hold on
set(gca,'ydir','reverse');
axis equal;
axis([0 width -height height]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画mu无穷%%%%%%%%%%%%%%%%%%%%
mu_infty = cross(L12_infty, contour_line);
%mu_infty = cross(L34_infty, contour_line);
mu_infty = mu_infty/mu_infty(3)
plot(mu_infty(1), mu_infty(2), '*');
hold on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%过椭圆外一点求切线%%%%%%%%%%%%%%%%%%
ellipse = [abcdef_High(1),   abcdef_High(2)/2, abcdef_High(4)/2;  
           abcdef_High(2)/2, abcdef_High(3),   abcdef_High(5)/2;  
           abcdef_High(4)/2, abcdef_High(5)/2, abcdef_High(6)];

%ellipse = ellipse/ellipse(3,3);  

%%极线
%mu_line=mu_infty'*ellipse;
mu_line=ellipse*mu_infty;
mu_line=mu_line/mu_line(3);

b=-mu_line(3)/mu_line(2); 
k=-mu_line(1)/mu_line(2);
x=0:0.1:width;
y = k*x+b;
plot(x,y,'c');

%%极点
% syms x y
% s=solve(abcdef_High(1)*x^2+abcdef_High(2)*x*y+abcdef_High(3)*y^2+ ...
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

legend('ellipse High' , 'L 12', 'L 34','contour line', 'mu infty', '极线');






















