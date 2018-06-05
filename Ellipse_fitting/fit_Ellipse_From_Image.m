function abcdef = fit_Ellipse_From_Image(image_file)
I=imread(image_file);
figure(1)
imagesc(I);
Igray=rgb2gray(I);
bwimg = Igray < 200;
[width,height]=size(bwimg);
figure(2)
imagesc(bwimg);

% ºÚ±³¾° °×Ïß
% [h,w]=size(I);
% x = [];
% y = [];
% t = 1;
% for i=1:h
%     for j=1:w
%         if(I(i,j) == 1)
%             x(t) = i;
%             y(t) = j;
%             t=t+1;
%         end
%     end
% end


% °×±³¾° ºÚÏß
x = [];
y = [];
t = 1;
for i=1:width
    for j=1:height
        if(bwimg(i,j) == 1)
            x(t) = i;
            y(t) = j;
            t=t+1;
        end
    end
end

% bw=rgb2gray(I);
% bw1=bw < 100;
% [x,y]=find(bw1==0);


figure(2);
h1 = gca;
scatter(y,x,5,'k');
set(h1,'ydir','reverse');
axis equal;
axis([0 height 0 width]);



zuobiao(:,1)=x';
zuobiao(:,2)=y';
%zuobiao(:,3)=1 ;
%save('corr_homo.mat','zuobiao');


randIndex = randperm(size(zuobiao,1));
zuobiao_new=zuobiao(randIndex,:);
zuobiao_new_ransac=ellipseDataFilter_RANSAC(zuobiao_new);
figure(3);
h1 = gca;
scatter(zuobiao_new_ransac(:,2),zuobiao_new_ransac(:,1),5,'k');
set(h1,'ydir','reverse');
axis equal;
axis([0 height 0 width]);



%abcdef = EllipseDirectFit(zuobiao_new_ransac);
abcdef = EllipseDirectFit(zuobiao_new);




% figure(3);
% h2 = gca;
% ellipse_t = fit_Ellipse( zuobiao_new(:,2),zuobiao_new(:,1), h2);
% set(h2,'ydir','reverse');
% axis equal;
% axis([0 height 0 width]);
% 
% a=getfield(ellipse_t,'long_axis');
% b=getfield(ellipse_t,'short_axis');
% X0=getfield(ellipse_t,'X0');
% Y0=getfield(ellipse_t,'Y0');
% 
% A = 1.0 / a^2;
% B = 0;
% C = 1 / b^2;
% D = -(2*X0) / a^2 ;
% E = 2.0 * Y0 /a^2;
% F = Y0 * Y0 / b^2 + X0 * X0 / a^2 ;
% 
% % disp(T)
% abcdef = [A, B, C, D, E, F];
% disp(abcdef);



% T=[ abcdef(1)    abcdef(2)/2  abcdef(4)/2;
%     abcdef(2)/2  abcdef(3)    abcdef(5)/2;
%     abcdef(4)/2  abcdef(5)/2  abcdef(6)];
% disp(T)
% % A = abcdef(1);
% % B = abcdef(2);
% % C = abcdef(3);
% % D = abcdef(4) ;
% % E = abcdef(5);
% % F = abcdef(6);
% 
% % figure(3);
% % syms x y;
% % ezplot('A*x^2+B*x*y+C*y^2+D*x+E*y+F = 0')
% % axis([0 1024 0 768]);
% 
% error = [];
% x_error = [];
% 
% for i = 1: length(zuobiao_new)
%     error(i) = A * zuobiao_new(i,2) * zuobiao_new(i,2) + C*zuobiao_new(i, 1)*zuobiao_new(i, 1) + D * zuobiao_new(i, 2) + E*zuobiao_new(i,1) + F;
%     x_error(i) = i;
% end
% 
for i = 1: length(zuobiao_new_ransac)
    error(i) = abcdef(1) * zuobiao_new_ransac(i,2) * zuobiao_new_ransac(i,2) + abcdef(3)*zuobiao_new_ransac(i, 1)*zuobiao_new_ransac(i, 1) + abcdef(4) * zuobiao_new_ransac(i, 2) + abcdef(5)*zuobiao_new_ransac(i,1) + abcdef(6);
    x_error(i) = i;
end
figure(4);
plot(x_error,error);


%catter(x_error,error,'k');
% 
% %plot(x_error,error);
% %save(output_name','T');
% 
% end

