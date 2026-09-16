close all, clear all, clc
dfk = 0.0001;
fk = 0.01:dfk:10.000;
wk = 2*pi*fk;
K = 204.9;                                                                  % DU/Volt
K1 = 500000;                                                                % Volt/Meter
K2 = 0.000016;                                                              % Meter/(Volt*Sec^2)
K3 = 31.6;                                                                  % Adimentional
wa = 0.0628;                                                                % Rad/Sec
FaTF = tf([1 0],[1 wa])                                                     % Adimentional
for k = 1:length(wk)
    s = i*wk(k);
    Fak(k) = s/(s + wa);                                                    % Adimentional
end
wl = 8.72665;                                                               % Rad/Sec
FlaTF = tf([wl^2],[1 2*cos(pi/8)*wl wl^2])                                  % Adimentional
for k = 1:length(wk)
    s = i*wk(k);
    Flak(k) = wl^2/(s^2 + 2*cos(pi/8)*wl*s + wl^2);                         % Adimentional
end
FlbTF = tf([wl^2],[1 2*cos(3*pi/8)*wl wl^2])                                % Adimentional
for k = 1:length(wk)
    s = i*wk(k);
    Flbk(k) = wl^2/(s^2 + 2*cos(3*pi/8)*wl*s + wl^2);                       % Adimentional
end
FlTF = (FlaTF)^2*(FlbTF)^2                                                  % Adimentional
for k = 1:length(wk)
    s = i*wk(k);
    Flk(k) = 3.363e07/(s^8 + 45.61*s^7 + 1040*s^6 + 1.533e04*s^5 + 1.584e05*s^4 + 1.168e06*s^3 + 6.032e06*s^2 + 2.014e07*s + 3.363e07);% Adimentional
end
f0 = 0.06667;                                                               % Hertz
w0 = 2*pi*f0;                                                               % Rad/Sec
h = 0.85;                                                                   % Adimentional

STF = tf([1],[1 2*h*w0 w0^2])                                               % Sec^2
for k = 1:length(wk)
    s = i*wk(k);
    Sk(k) = 1/(s^2 + 2*h*w0*s + w0^2);                                      % Sec^2
end
wd = 47.62;                                                                 % Rad/Sec
FdTF = tf([wd],[1 wd])                                                      % Adimentional
for k = 1:length(wk)
    s = i*wk(k);
    Fdk(k) = wd/(s + wd);                                                   % Adimentional
end

wf = 0.000997;                                                              % Rad/Sec
FfTF = tf([wf],[1 wf])                                                      % Adimentional
for k = 1:length(wk)
    s = i*wk(k);
    Ffk(k) = wf/(s + wf);                                                   % Adimentional
end
Flat_aTF = K*K3*FaTF*FlTF*feedback(K1*STF*FdTF,K2*FfTF)                     % DU*Sec^2/Meter
for k = 1:length(wk)
    s = i*wk(k);
    Flat_ak(k) = (5.185e18*s^2 + 5.17e15*s)/(s^13 + 94*s^12 + 3284*s^11 + 6.737e04*s^10 + 9.395e05*s^9 + 9.415e06*s^8 + 6.859e07*s^7+ 3.571e08*s^6 + 1.245e09*s^5 + 2.441e09*s^4 + 1.468e09*s^3 + 3.729e08*s^2+ 3.127e07*s + 8.199e05);% DU*Sec^2/Meter
end
Flat_vTF = Flat_aTF*tf([1 0],[1])                                           % DU*Sec/Meter
for k = 1:length(wk)
    s = i*wk(k);
    Flat_vk(k) = (5.185e18*s^3 + 5.17e15*s^2)/(s^13 + 94*s^12 + 3284*s^11 + 6.737e04*s^10 + 9.395e05*s^9 + 9.415e06*s^8 + 6.859e07*s^7+ 3.571e08*s^6 + 1.245e09*s^5 + 2.441e09*s^4 + 1.468e09*s^3 + 3.729e08*s^2+ 3.127e07*s + 8.199e05);% DU*Sec/Meter
end
Flat_dTF = Flat_vTF*tf([1 0],[1])% DU*Sec/Meter
for k = 1:length(wk)
    s = i*wk(k);
    Flat_dk(k) = (5.185e18*s^4 + 5.17e15*s^3)/(s^13 + 94*s^12 + 3284*s^11 + 6.737e04*s^10 + 9.395e05*s^9 + 9.415e06*s^8 + 6.859e07*s^7+ 3.571e08*s^6 + 1.245e09*s^5 + 2.441e09*s^4 + 1.468e09*s^3 + 3.729e08*s^2+ 3.127e07*s + 8.199e05);% DU*Sec/Meter
end
Peak_aTF = K*K3*FaTF*FlTF*feedback(STF*K1*FdTF,K2)                                  % DU*Sec^2/Meter
for k = 1:length(wk)
    s = i*wk(k);
    Peak_ak(k) = 5.185e18*s/(s^12 + 94*s^11 + 3284*s^10 + 6.775e04*s^9 + 9.569e05*s^8 + 9.811e06*s^7 + 7.444e07*s^6 + 4.178e08*s^5 + 1.693e09*s^4 + 4.765e09*s^3 + 9.281e09*s^2 + 1.366e10*s + 8.223e08);
end
Peak_vTF = Peak_aTF*tf([1 0],[1])                                           % DU*Sec/Meter
for k = 1:length(wk)
    s = i*wk(k);
    Peak_vk(k) = 5.185e18*s^2/(s^12 + 94*s^11 + 3284*s^10 + 6.775e04*s^9 + 9.569e05*s^8 + 9.811e06*s^7 + 7.444e07*s^6 + 4.178e08*s^5 + 1.693e09*s^4 + 4.765e09*s^3 + 9.281e09*s^2 + 1.366e10*s + 8.223e08);
end
Peak_dTF = Peak_vTF*tf([1 0],[1])% DU*Sec/Meter
for k = 1:length(wk)
    s = i*wk(k);
    Peak_dk(k) = 5.185e18*s^3/(s^12 + 94*s^11 + 3284*s^10 + 6.775e04*s^9 + 9.569e05*s^8 + 9.811e06*s^7 + 7.444e07*s^6 + 4.178e08*s^5 + 1.693e09*s^4 + 4.765e09*s^3 + 9.281e09*s^2 + 1.366e10*s + 8.223e08);
end
hfig = figure;
loglog(fk,0.01*abs(Flat_dk),'k',fk,0.01*abs(Peak_dk),'r');
xlim([0.01 10]);
ylim([10^3 10^9]);
xlabel('Frequency, Hz');
ylabel('Sensitivity, DU/cm');
legend('Apollo LP - Flat Mode','Apollo LP - Peak Mode');
grid on;
oldunits = hfig.Units;
set(gcf, 'PaperUnits', 'centimeters', 'Units', 'centimeters');
figpos = get(gcf, 'Position');
set(gcf, 'PaperSize', figpos(3:4), 'Units', oldunits);
print('-f1','-dpdf','TF-DUcm.pdf');
close (gcf);