function contour_line = findLineContour(image)
RGB = imread(image);%Read the image
Highlight=RGB;
I=rgb2gray(RGB); %transform the image to gray
[x,y]=size(I);   %get the size of the picture
BW=edge(I);      %get the edge of the picture


rho_max=floor(sqrt(x^2+y^2))+1; %��ԭͼ����������������ֵ����ȡ�������ּ�1
%��ֵ��Ϊ�ѣ�������ϵ�����ֵ
accarray=zeros(rho_max,180); %����ѣ�������ϵ�����飬��ֵΪ0��
%�ȵ����ֵ��180��

Theta=[0:pi/180:pi]; %��������飬ȷ����ȡֵ��Χ

for n=1:x,
    for m=1:y
        if BW(n,m)==1
            for k=1:180
            %����ֵ����hough�任���̣����ֵ
                rho=(m*cos(Theta(k)))+(n*sin(Theta(k)));
                %����ֵ������ֵ�ĺ͵�һ����Ϊ�ѵ�����ֵ���������꣩����������Ϊ�˷�ֹ��ֵ���ָ���
                rho_int=round(rho/2+rho_max/2);
                %�ڦѦ����꣨���飩�б�ʶ�㣬�������ۼ�
                accarray(rho_int,k)=accarray(rho_int,k)+1;
            end
        end
    end
end



%=======����hough�任��ȡֱ��======%
%Ѱ��100���������ϵ�ֱ����hough�任���γɵĵ�
%Ѱ��һ�����ֱ���ϵĵ�

K=3; %�洢���������
min_length = 100;
while (K>=3)
    K=1;
    min_length =min_length+1;
    for rho_n=1:rho_max %��hough�任�������������
        for theta_m=1:180
            if accarray(rho_n,theta_m)>=min_length%�趨ֱ�ߵ���Сֵ��
            case_accarray_n(K)=rho_n; %�洢�������������±�
            case_accarray_m(K)=theta_m;
            K=K+1;
            end
        end
    end
end

%=====����Щ�㹹�ɵ�ֱ����ȡ����,���ͼ������ΪI_out===%
I_out=zeros(x,y);
I_jiao_class=zeros(x,y);

X=[];
Y=[];
count  =1;
for n=1:x,
    for m=1:y
         if BW(n,m)==1
             for k=1:180
              rho=(m*cos(Theta(k)))+(n*sin(Theta(k)));
              rho_int=round(rho/2+rho_max/2);             
                for a=1:K-1    
                    if rho_int==case_accarray_n(a)&k==case_accarray_m(a)%%%==gai==%%% k==case_accarray_m(a)&rho_int==case_accarray_n(a)
                    I_out(n,m)=BW(n,m); 
                    X(count)=n;
                    Y(count)=m;
                    count = count+1;
                        for p=0:5 %��ԭRGBͼ���ϸ���
                         Highlight(n,m+p,1)=255;
                         Highlight(n,m+p,2)=0;
                         Highlight(n,m+p,3)=0;
                        end
                    I_jiao_class(n,m)=k;
                    end
                end
             end
         end
    end
end


% Y = p(1)X + p(2)
p = polyfit(Y,X,1);
contour_line = [p(1), -1, p(2)]' /p(2)
save contour_line contour_line
figure(1);
plot(Y,X,'o',X,polyval(p,X));
set(gca,'ydir','reverse');
axis equal;
axis([0 y 0 x]);

figure(2),imshow(Highlight);
title('�������ͼ');
%imwrite(Highlight,'�������ͼ.jpg','jpg');