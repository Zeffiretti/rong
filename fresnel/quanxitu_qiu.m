clear all
clc

[data1,data2,data3,data4,data5,data6] = textread('data.txt','%f%f%f%f%f%f');

O_X = data1*8/10e5;
O_Y = data2*8/10e5;
O_Z = data3*8/10e5;

O_X = O_X-2e-4;
O_Y = O_Y-2e-4;
O_Z = O_Z-2e-4;


scatter3(O_X,O_Y,O_Z,'.');
xlabel('x');
ylabel('y');
zlabel('z');

H_number=1001;
H_size=300e-6;
H_X=linspace(-H_size/2,H_size/2,1000);
H_Y=linspace(-H_size/2,H_size/2,1000);
[H_X,H_Y]=meshgrid(H_X,H_Y);

Z0=0.06;
lamda=633e-9;
K=2*pi/lamda;
O_A=1;
[dianshu1,dianshu2]=size(O_Z);
%xiangwei=rand(dianshu1,1)*6.28;

for m = 1:H_number
    H_number = H_number-m
    for j=1:H_number
        for k=1:dianshu1
            d=Z0-O_Z(k);
            T=O_A.*exp((i*pi/lamda/d).*(O_X(k).^2+O_Y(k).^2));
            CA(k)=exp(i*pi/lamda/d*(H_X(m,j).^2+H_Y(m,j).^2)).*fftshift(fft2(T));
        end
        H_A(m,j)=sum(CA);
    end
end
save qiu_100_ifresnel_12 H_A
