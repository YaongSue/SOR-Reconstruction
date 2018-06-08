clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%ground truth%%%%%%%%%%%%%%
load('f.mat')
fx = f;
fy = f;
cx = 540;
cy = 360;
k_groundtruth = [fx,     0,     cx;
                 0,      fy,    cy;
                 0,      0,     1  ];
w_inverse_groundtruth = k_groundtruth*k_groundtruth';
w_chol = chol(w_inverse_groundtruth);
w_chol= w_chol/w_chol(3,3)
w_groundtruth = w_inverse_groundtruth^-1

w_groundtruth_2 = [1/(fx^2),        0,               -1*cx/(fx^2);
                   0,               1/(fy^2),        -1*cy/(fy^2);
                  -1*cx/(fx^2),     -1*cy/(fy^2),    (cx/fx)^2+(cy/fy)^2+1]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%load fixed entities%%%%%%%%%%%%
load('v_infty.mat');
load('ls.mat');
load('x1_I.mat');
load('x1_J.mat');
load('x2_I.mat');
load('x2_J.mat');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%确定fixed entities解的是否正确%%%%%%

error_I1 = x1_I'*w_groundtruth*x1_I;
error_J1 = x1_J'*w_groundtruth*x1_J;
error_I2 = x2_I'*w_groundtruth*x2_I;
error_J2 = x2_J'*w_groundtruth*x2_J;

error_v_infty = cross(ls,(w_groundtruth*v_infty));
w_Vinfty = w_groundtruth*v_infty;
w_Vinfty = w_Vinfty/w_Vinfty(3);

fprintf('error_I1 = %f\n', error_I1 );
fprintf('error_J1 = %f\n', error_J1 );
fprintf('error_I2 = %f\n', error_I2 );
fprintf('error_J2 = %f\n', error_J2 );
fprintf('error_v_infty = \n');
disp(error_v_infty);
fprintf('w * v_infty = \n');
disp(w_Vinfty);
fprintf('ls = \n');
disp(ls);


fprintf('use w_groundtruth_2 \n' );

error_I1 = x1_I'*w_groundtruth_2*x1_I;
error_J1 = x1_J'*w_groundtruth_2*x1_J;
error_I2 = x2_I'*w_groundtruth_2*x2_I;
error_J2 = x2_J'*w_groundtruth_2*x2_J;

error_v_infty = cross(ls,(w_groundtruth_2*v_infty));
w_Vinfty = w_groundtruth_2*v_infty;
w_Vinfty = w_Vinfty/w_Vinfty(3);

fprintf('error_I1 = %f\n', error_I1 );
fprintf('error_J1 = %f\n', error_J1 );
fprintf('error_I2 = %f\n', error_I2 );
fprintf('error_J2 = %f\n', error_J2 );
fprintf('error_v_infty = \n');
disp(error_v_infty);
fprintf('w * v_infty = \n');
disp(w_Vinfty);
fprintf('ls = \n');
disp(ls);




















