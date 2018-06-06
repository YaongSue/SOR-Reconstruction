clear
clc;


load('30_1.mat');
load('30_2.mat');

img_width = 1080;
img_height = 720;


syms x;
syms y;
digits(10);
%ax^2 + bxy + cy^2 +dx + ey + f = 0
z1=abcdef_High(1)*y^2+abcdef_High(2)*x*y+abcdef_High(3)*x^2+abcdef_High(4)*y+abcdef_High(5)*x+abcdef_High(6);
z2=abcdef_Low(1)*y^2+abcdef_Low(2)*x*y+abcdef_Low(3)*x^2+abcdef_Low(4)*y+abcdef_Low(5)*x+abcdef_Low(6);
figure(1);
h1=ezplot(z1,[0,img_width,0,img_height]);
set(h1,'Color','r');
hold on;
h2=ezplot(z2,[0,img_width,0,img_height]);
set(h2,'Color','b');
set(gca,'ydir','reverse');
title('Ls && L-infty && Cross Sections');


result=solve(z1,z2);
xx=result.x;
S_vpa_x = vpa(xx);
yy=result.y;
S_vpa_y = vpa(yy);
xxx=double(S_vpa_x);
yyy=double(S_vpa_y);
xk=[xxx,yyy];


x1_I=[xk(1,:),1]';
x1_J=[xk(2,:),1]';
x2_I=[xk(3,:),1]';
x2_J=[xk(4,:),1]';

fprintf( 'x_k = \n ');
disp(x1_I);
disp(x1_J);
disp(x2_I);
disp(x2_J);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the six lines
L_12 = cross(x1_I, x1_J);
L_34 = cross(x2_I, x2_J);
L_12 = L_12/L_12(3);
L_34 = L_34/L_34(3);
L12_infty = L_12;
L34_infty = L_34;


figure(2);
b=-1/L_12(2); 
k=-1*L_12(1)/L_12(2);
x=0:0.1:img_width;
y = k*x+b;
plot(x,y,'r');
legend('L 12')
hold on

figure(1);
plot(x,y,'r');
legend('L 12')
hold on





b=-1/L_34(2); 
k=-1*L_34(1)/L_34(2);
x=0:0.1:img_width;
y = k*x+b;
plot(x,y,'b');
title('L-inftys');
set(gca,'ydir','reverse');
hold on

figure(1);
plot(x,y,'b');
hold on


L_13 = cross(x1_I, x2_I);
L_24 = cross(x1_J, x2_J);

L_14 = cross(x1_I, x2_J);
L_23 = cross(x1_J, x2_I);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%v_infty = L12 x L34
fprintf('v_infty = \n ');
v_infty =cross(L_12, L_34);
v_infty = v_infty/v_infty(3);
disp(v_infty);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ls = (L_13 x L_24) x (L_14 x L_23)
fprintf('ls = \n ');
ls = cross(cross(L_13, L_24),cross(L_14, L_23));
ls = ls/ls(3);

disp(ls);
b=-1/ls(2); 
k=-1*ls(1)/ls(2);
x=0:0.1:img_width;
y = k*x+b;
figure(1);
plot(x,y);
axis([0 img_width 0 img_height]);
set(gca,'ydir','reverse');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save x1_I x1_I;
save x1_J x1_J; 
save x2_I x2_I; 
save x2_J x2_J;

save ls ls;
save v_infty v_infty;
save L12_infty L12_infty;
save L34_infty L34_infty;