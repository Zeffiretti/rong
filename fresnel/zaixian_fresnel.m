clear
clc
close all
load qiu_100_ifresnel_12.mat H_A
%load aircraft_H_C_A_2500.mat%(这里H_A为1500×1500)
%load 2503_plane_points_complex_amplitude.mat
%H_size=226e-6;
H_size = 300e-6;
H_X = linspace(-H_size/2,H_size/2,1000);%%全息面的坐标
H_Y = linspace(-H_size/2,H_size/2,1000);
[H_X, H_Y]=meshgrid(H_X,H_Y);
lamda = 633e-9;
d = -0.1;
% d=410e-6;
K = 2 * pi/lamda;
% phase=angle(H_A);
% phase2=mod(2*pi,phase);
inter = exp(angle(H_A) * 1i);
%inter=1.*angle(H_A);
%inter=H_A;
% R=exp(i*K*(H_X*cos(alpha)+H_Y*cos(beita)));
% inter=H_A./max(max(H_A.*conj(H_A)))+R;
% inter=inter.*conj(inter);
figure, imshow(inter,[])
L = 1000*lamda*d/H_size;
x = linspace(-L/2,L/2,1000);
y=linspace(-L/2,L/2,1000);
[x,y]=meshgrid(x,y);
% imshow(inter,[])    
F0 = exp(1i * K * d)/(1i * lamda * d) * exp(1i * K/2/d * (x.^2+y.^2));
%F0=exp(i*K/2/d*(x.^2+y.^2));
F = exp(1i * K/2/d*(H_X.^2 + H_Y.^2));
inter1 = inter*F;
fH_A = fftshift(fft2(inter1));
fuH_A = fH_A*F0;
Ob_I=fuH_A.*conj(fuH_A);
figure,imagesc(Ob_I,[0,max(max(Ob_I))])
axis equal