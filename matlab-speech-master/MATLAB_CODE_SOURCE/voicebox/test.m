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
         do_env=1; do_hp=1;                            % flags to control options
         [b,a,fx,bx,gd]=gammabank(25,fs,'',[80 5000]); % determine filterbank
         y=filterbank(b,a,s,gd);                       % filter signal s
         if do_env
             [bl,al]=butter(3,2*800/fs);
             y=filter(bl,al,teager(y,1),[],1);           % low pass envelope @ 800 Hz
         end
         if do_hp
             y=filter(fir1(round(16e-3*fs),2*64/fs,'high'),1,y,[],1);  % HP filter @ 64 Hz
         end
         correlogram(y,round(10e-3*fs),round(16e-3*fs),round(12e-3*fs),'',fs);