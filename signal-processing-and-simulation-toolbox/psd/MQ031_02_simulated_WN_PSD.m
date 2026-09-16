close all
clear all
clc
fs = 6;
L = 10^5;
N = 2048;
rng('default');
x = randn(N,L);
b = fir1(64, 0.5);
nb = filter(b,1,x);
var = 2.0;
scale = (sqrt(var)*ones(1,L))/std(nb);
nb = scale*nb;
fvec = fs*[0:N/2]/N;
y = 1/sqrt(N)*fft(nb);
y2 = y.*conj(y);
y3 = y2';
P2 = mean(y3);
P1 = P2(1:N/2+1);
%P1(2:end-1) = 2*P1(2:end-1);
hfig = figure('units','normalized','outerposition',[0 0 1 1]);
set(gcf,'Color','k','inverthardcopy','off');
p1 = semilogx(fvec,db(P1),'Color',[0.8500, 0.3250, 0.0980],'linewidth',2);
set(gca,'Color','k','YColor','w','XColor','w','GridColor','w');
xlim([0.9*10^-2 1.1*3.3])
ylim([0 20]);
grid on;
ylabel('Power Spectral Density [dB/Hz]','fontsize',12,'FontWeight','bold');
xlabel('Frequency [HZ]','fontsize',12,'FontWeight','bold');
title_str = ['Simulated PSD of BLWN'];
ttl = title(title_str,'fontsize',15,'FontWeight','bold');
set(ttl,'Color','w');
filename_str = ['BLWN_Spectrum.jpg'];
saveas(hfig,filename_str);                
% close (gcf);
