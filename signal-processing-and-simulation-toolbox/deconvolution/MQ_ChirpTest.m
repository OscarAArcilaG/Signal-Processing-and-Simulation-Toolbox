close all;
clear variables;
clc;
fs = 6.6;
dt = 1/fs;
T = 1000;
tt = 0:dt:(T-dt);
N = length(tt);
x = (1e-9)*chirp(tt,0.05,T,10,'logarithmic');
% x = awgn(x,190,rms(x)^2);
%%
num = [5.185e18 0];
den = [1 94 3284 6.775e04 9.569e05 9.811e06 7.444e07 4.178e08 1.693e09 4.765e09 9.281e09 1.366e10 8.223e08];
H = tf(num,den);
y = lsim(H,x,tt).';
ffty = fft(y);
%%
impulse= tt==0;
ffth=fft(lsim(H,impulse,tt)).';
k = 0.003;
wl = k*max(abs(ffth));
for i= 1:N
	fftRx(i) = (ffty(i)*conj(ffth(i)))/(max(abs(ffth(i)),wl))^2;
end
Rx = real(ifft(fftRx));
%%
N = length(x);
[b,a] = butter(8,1.7/(fs/2),'low');
x = filtfilt(b,a,x);
nfft = 2^(nextpow2(N)-6);
noverlap = nfft/2;
window = nfft;
[psdx,fx] = pwelch(x,nfft,noverlap,window,fs);
[psdRx,fRx] = pwelch(Rx,nfft,noverlap,window,fs);
%%
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,1,1);
p1 = plot(tt,x);
% title('Señal de Prueba Sometida a Deconvolución por Nivel de Agua');
grid on;
hold on;
p2 = plot(tt,Rx);
hold off;
lgd = legend([p1 p2],{'Original','Deconvolucionado'},'fontsize',10,'FontWeight','bold','location','northeast');
title(lgd,'Sismograma','fontsize',10,'FontWeight','bold');
ylabel('Desplazamiento [m]','FontWeight','bold');
xlabel('Tiempo [s]','FontWeight','bold');
axis('tight');
subplot(2,1,2);
p1 = semilogx(fx,db(psdx));
grid on;
hold on;
p2 = semilogx(fRx,db(psdRx));
hold off;
lgd = legend([p1 p2],{'Original','Deconvolucionado'},'fontsize',10,'FontWeight','bold','location','northeast');
title(lgd,'PSD','fontsize',10,'FontWeight','bold');
ylabel('Amplitud [dB]','FontWeight','bold');
xlabel('Frecuencia [Hz]','FontWeight','bold');
100*(1-goodnessOfFit(x(:),Rx(:),'NRMSE'))
100*(1-goodnessOfFit(psdx,psdRx,'NRMSE'))