close all, clear all, clc, warning off
folder = pwd;
cd (folder)



%% 
dt = 0.001;
t = 0:dt:4;
y = 2*sin(2*pi*5*t) + 3*sin(2*pi*10*t);
hfig = figure;
plot(t,y);



%% 
Y = fft(y);
N = length(y);
fs = 1/dt;
fk = fs*(0:(N/2))/N;
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
hfig = figure;
plot(fk,P1);



%% 
nfft = 2^10;
noverlap = nfft/2;
window = hanning(nfft);
[psd,f] = pwelch(y,window,noverlap,nfft,fs);
hfig = figure;
plot(f,db(psd),'linewidth',1.5);