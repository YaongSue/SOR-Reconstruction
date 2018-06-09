clear;

%% load fixed entities
load('v_infty.mat');
load('ls.mat');
load('x1_I.mat');
load('x1_J.mat');
load('x2_I.mat');
load('x2_J.mat');

A = v_infty(1);
B = v_infty(2);
as = ls(1);
bs = ls(2);
I = x1_I;
J = x1_J;
% I = x2_I;
% J = x2_J;
a1 = I(1);
b1 = I(2);
a2 = J(1);
b2 = J(2);


%% 求解绝对圆锥曲线和相机焦距
C=[  a1^2+b1^2, 2*a1,   2*b1,     1;
     a2^2+b2^2, 2*a2,   2*b2,     1;
     -B,        bs*A,   B*bs-1, bs; 
     A,         1-as*A, -as*B,    -as;
     as*B-bs*A, -bs,    as,       0];

save C C;
[U S V] = svd(C)
w = [V(1,4), 0, V(2,4); 0, V(1,4), V(3,4); V(2,4), V(3,4), V(4,4)];

w_inverse = w^-1;
w_inverse = w_inverse/w_inverse(3,3)
% w_inverse_real = real(w_inverse)
% k = chol(w_inverse_real)
% k = k/k(3,3)
% f = (k(1,1) + k(2,2))/2
% 
% save w_inverse w_inverse
% save k k
% save f f

save w w 

%% 求解绝对圆锥曲线和相机焦距
% C=[  a1^2+b1^2, 2*a1,   2*b1;
%      -B,        bs*A,   B*bs-1; 
%      A,         1-as*A, -as*B];
% 
% BB = [-1, -bs, as]';
% w123 = C\BB;
% 
% w = [w123(1), 0, w123(2); 0, w123(1), w123(3); w123(2), w123(3), 1]
% w_inverse = w^-1
% w_inverse_real = real(w_inverse)
% k = chol(w_inverse_real);
% k = k/k(3,3)
% f = (k(1,1) + k(2,2))/2
%  
% save w_inverse w_inverse
% save k k
% save f f






