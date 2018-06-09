clear;

cx = 531.860786176345;
cy = 384.513187498083;

load('v_infty.mat');
load('ls.mat');
load('x1_I.mat');
load('x1_J.mat');
load('x2_I.mat');
load('x2_J.mat')

a1 = x1_I(1);
b1 = x1_I(2);
A = v_infty(1);
B = v_infty(2);
as = ls(1);
bs = ls(2);


% a1 = x2_I(1);
% b1 = x2_I(2);

f1 = -1 / ((a1^2+b1^2)-cx*2*a1- cy*2*b1+cy^2+cx^2);
f1 =1/f1;
f1 =f1^0.5

f2 = as/(A-cx*(1-as*A)+cy*as*B-cx^2*as-cy^2*as);
f2 =1/f2;
f2 =f2^0.5


f3 = -bs/(-1*B-bs*A*cx-cy*(B*bs-1)+bs*cx^2+bs*cy^2);
f3 =1/f3;
f3 =f3^0.5
f =real(f1+f2+f3)/3
save f f