close all, clear all, clc
%cut fracuency 30 Hz
%damping 0.99
numeq = [2*0.99*5 (2*pi*30)^2];
deneq = [1 2*0.99*(2*pi*30) (2*pi*30)^2];
H = tf(numeq,deneq);
[Aeq,Beq,Ceq,Deq] = tf2ss(numeq,deneq);
ss_eq = ss(Aeq,Beq,Ceq,Deq);
bode(H,ss_eq)
[mag,ph,w] = bode(ss_eq);
hfig = figure;
subplot(211);
semilogx(w,db(squeeze(mag)));
title('Kanai-Tajimi Filter');
ylabel('Magnitude (dB)');
xlim([10 10^5]);
ylim([-100 0]);
subplot(212);
semilogx(w,squeeze(ph));
xlabel('Frequency (rad/s)');
ylabel('Phase (deg)');
xlim([10 10^5]);
ylim([-180 0]);
wvec = logspace(-3,5,10^3);
fvec = wvec/2/pi;
s = i*wvec;
for ii=1:10^3
    hs(ii) = (9.9*s(ii) + 3.553e04 )/(s(ii)^2 + 373.2*s(ii) + 3.553e04);
end
hfig = figure;
subplot(211);
semilogx(wvec,db(abs(hs)));
title('Kanai-Tajimi Filter');
ylabel('Magnitude (dB)');
xlim([10 10^5]);
ylim([-100 0]);
subplot(212);
semilogx(wvec,angle(hs)/pi*180);
xlabel('Frequency (rad/s)');
ylabel('Phase (deg)');
xlim([10 10^5]);
ylim([-180 0]);
%% Preferred by Dyke and Gómez
[mag,ph] = bode(ss_eq,wvec);
hfig = figure;
subplot(211);
semilogx(fvec,db(abs(hs)),'r',wvec,db(abs(hs)));
title('Kanai-Tajimi Filter');
ylabel('Magnitude (dB)');
xlim([10/2/pi 10^5]);
ylim([-100 0]);
subplot(212);
semilogx(fvec,angle(hs)/pi*180,'r',wvec,angle(hs)/pi*180);
xlabel('Frequency (Hz)');
ylabel('Phase (deg)');
xlim([10/2/pi 10^5]);
ylim([-180 0]);
hfig = figure;
subplot(211);
semilogx(fvec,db(abs(hs)));
title('Kanai-Tajimi Filter');
ylabel('Magnitude (dB)');
xlim([10 10^5]/2/pi);
ylim([-100 0]);
subplot(212);
semilogx(fvec,angle(hs)/pi*180);
xlabel('Frequency (Hz)');
ylabel('Phase (deg)');
xlim([10 10^5]/2/pi);
ylim([-180 0]);