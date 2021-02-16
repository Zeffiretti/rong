% x = randn(1000,1);         % 1000 Gaussian deviates ~ N(0,1)
% y = filter([1 -1 1],1,x);  % Create an MA(2) process
% [x, fs] = audioread('test.wav');
% [acf,lags,bounds] = autocorr(x);
% stem(lags,acf); xlabel('Lag'); ylabel('\rho(k)');
% hold on;
% h = line(lags,bounds(1)*ones(length(acf),1));
% h1 = line(lags,bounds(2)*ones(length(acf),1));
% set(h,'color',[1 0 0]);
% set(h1,'color',[0 1 0]);
[x, fs] = audioread('test.wav');
[y, z0] = v_filterbank(10, 1, x);
correlogram(y);
