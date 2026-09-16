close all, clear all, clc
% The Apollo Seismometer Responses
%
% This scrip details the calculus and plots, of the Apollo PSE sismometers
% transference functions for acceleration, velocity, and displacement.
% It contains specific details about the internal components of the Long
% Period (LP) and Short period (SP) seismometers and takes into
% consideration that there is a flat and a peak mode for the LP
% seismometer.
%
%
% Vector of Frequencies
dfk = 0.001;
fk = dfk:dfk:25.000;
wk = 2*pi*fk;










%% LP seismometer
% This seismometer is sensible to relative displacement.
% Operational Amplifier's Constants
%
%
K = 204.9;                                                                  % DU/Volt
K1 = 500000;                                                                % Volt/Meter
K2 = 0.000016;                                                              % Meter/(Volt*Sec^2)
K3 = 31.6;                                                                  % Adimentional
%
%










%% Amplifier Filter Fa
%
%
wa = 0.0628;                                                                % Rad/Sec
%
%
% Transfer Function Fa(s)
FaTF = tf([1 0],[1 wa])                                                     % Adimentional
%
%
% Transfer Function Fa(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Fak(k) = s/(s + wa);                                                    % Adimentional
end
%
%
% Plot of the Transfer Function Fa
% Circular Frequency
hfig = figure;
loglog(fk,abs(Fak),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function Fa (Adimentional)');
title('1-st order high-pass Fa filter');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Fa.pdf');
%
%










%% Low-Pass Antialiasing Filter Fl
%
%
wl = 8.72665;                                                               % Rad/Sec
%
%










%% Part A of the Filter Fl  (Fla)
%
%
% Transfer Function Fla(s)
FlaTF = tf([wl^2],[1 2*cos(pi/8)*wl wl^2])                                  % Adimentional
%
%
% Transfer Function Fla(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Flak(k) = wl^2/(s^2 + 2*cos(pi/8)*wl*s + wl^2);                         % Adimentional
end
%
%
% Plot of the Transfer Function Fla
% Circular Frequency
hfig = figure;
loglog(fk,abs(Flak),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Adimentional)');
title('2-nd order low-pass Fla filter');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Fla.pdf');
%
%










%% Part A of the Filter Fl  (Flb)
%
%
% Transfer Function Flb(s)
FlbTF = tf([wl^2],[1 2*cos(3*pi/8)*wl wl^2])                                % Adimentional
%
%
% Transfer Function Flb(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Flbk(k) = wl^2/(s^2 + 2*cos(3*pi/8)*wl*s + wl^2);                       % Adimentional
end
%
%
% Plot of the Transfer Function Flb
% Circular Frequency
hfig = figure;
loglog(fk,abs(Flbk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Adimentional)');
title('2-nd order low-pass Flb filter');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Flb.pdf');
%
%










%% Complete Filter Fl
%
% Transfer Function Fl(s)
FlTF = (FlaTF)^2*(FlbTF)^2                                                  % Adimentional
%
%
% Transfer Function Fl(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Flk(k) = 3.363e07/(s^8 + 45.61*s^7 + 1040*s^6 + 1.533e04*s^5 + 1.584e05*s^4 + 1.168e06*s^3 + 6.032e06*s^2 + 2.014e07*s + 3.363e07);% Adimentional
end
%
%
% Plot of the Transfer Function Fl
% Circular Frequency
hfig = figure;
loglog(fk,abs(Flk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Adimentional)');
title('8-th order low-pass Fl filter');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Fl.pdf');
%
%










%% Seismometer Acceleration Transfer Function S
%
f0 = 0.06667;                                                               % Hertz
w0 = 2*pi*f0;                                                               % Rad/Sec
h = 0.85;                                                                   % Adimentional
%
%
% Transfer Function S(s)
STF = tf([1],[1 2*h*w0 w0^2])                                               % Sec^2
%
%
% Transfer Function S(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Sk(k) = 1/(s^2 + 2*h*w0*s + w0^2);                                      % Sec^2
end
%
%
% Plot of the Transfer Function S
% Circular Frequency
hfig = figure;
loglog(fk,abs(Sk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Sec^2)');
title('Seismometer Tranfer Function (Acceleration)');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_S.pdf');
%
%










%% Demodulator Transfer Function Fd
%
%
wd = 47.62;                                                                 % Rad/Sec
%
%
% Transfer Function Fd(s)
FdTF = tf([wd],[1 wd])                                                      % Adimentional
%
%
% Transfer Function Fd(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Fdk(k) = wd/(s + wd);                                                   % Adimentional
end
%
%
% Plot of the Transfer Function Fd
% Circular Frequency
hfig = figure;
loglog(fk,abs(Fdk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Adimentional)');
title('Demodulator Tranfer Function');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Fd.pdf');
%
%










%% Feedback Transfer Function Ff
%
%
wf = 0.000997;                                                              % Rad/Sec
%
%
% Transfer Function Ff(s)
FfTF = tf([wf],[1 wf])                                                      % Adimentional
%
%
% Transfer Function Ff(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Ffk(k) = wf/(s + wf);                                                   % Adimentional
end
%
%
% Plot of the Transfer Function Ff
% Circular Frequency
hfig = figure;
loglog(fk,abs(Ffk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Adimentional)');
title('1-st Order Feedback Filter Ff Tranfer Function');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Ff.pdf');
%
%










%% Flat Acceleration Transfer Function Flat_aTF
% 
%
% Transfer Function Flat_aTF(s)
%
Flat_aTF = K*K3*FaTF*FlTF*feedback(K1*STF*FdTF,K2*FfTF)                     % DU*Sec^2/Meter
%
%
% Transfer Function Flat_ak(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Flat_ak(k) = (5.185e18*s^2 + 5.17e15*s)/(s^13 + 94*s^12 + 3284*s^11 + 6.737e04*s^10 + 9.395e05*s^9 + 9.415e06*s^8 + 6.859e07*s^7+ 3.571e08*s^6 + 1.245e09*s^5 + 2.441e09*s^4 + 1.468e09*s^3 + 3.729e08*s^2+ 3.127e07*s + 8.199e05);% DU*Sec^2/Meter
end
%
%
% Plot of the Transfer Function Flat_aTF
% Circular Frequency
hfig = figure;
loglog(fk,abs(Flat_ak),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (DU*s^2/m)');
title('Flat Aceleration Tranfer Function');
grid on;
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Flat_aTF.pdf');
%
%










%% Flat Velocity Transfer Function Flat_vTF
%
%
% Transfer Function Flat_vTF(s)
Flat_vTF = Flat_aTF*tf([1 0],[1])                                           % DU*Sec/Meter
%
%
% Transfer Function Flat_vk(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Flat_vk(k) = (5.185e18*s^3 + 5.17e15*s^2)/(s^13 + 94*s^12 + 3284*s^11 + 6.737e04*s^10 + 9.395e05*s^9 + 9.415e06*s^8 + 6.859e07*s^7+ 3.571e08*s^6 + 1.245e09*s^5 + 2.441e09*s^4 + 1.468e09*s^3 + 3.729e08*s^2+ 3.127e07*s + 8.199e05);% DU*Sec/Meter
end
%
%
% Plot of the Transfer Function
% Circular Frequency
hfig = figure;
loglog(fk,abs(Flat_vk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (DU*s/m)');
title('Flat Velocity Tranfer Function');
grid on;
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Flat_vTF.pdf');
%
%










%% Flat Displacement Transfer Function Flat_dTF
%
%
% Transfer Function Flat_dTF(s)
Flat_dTF = Flat_vTF*tf([1 0],[1])% DU*Sec/Meter
%
%
% Transfer Function Flat_dk(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Flat_dk(k) = (5.185e18*s^4 + 5.17e15*s^3)/(s^13 + 94*s^12 + 3284*s^11 + 6.737e04*s^10 + 9.395e05*s^9 + 9.415e06*s^8 + 6.859e07*s^7+ 3.571e08*s^6 + 1.245e09*s^5 + 2.441e09*s^4 + 1.468e09*s^3 + 3.729e08*s^2+ 3.127e07*s + 8.199e05);% DU*Sec/Meter
end
%
%
% Plot of the Transfer Function
% Circular Frequency
hfig = figure;
loglog(fk,abs(Flat_dk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (DU/m)');
title('Flat Tranfer Function (Displacement)');
grid on;
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Flat_dTF.pdf')
%
%










%% Peak Acceleration Transfer Function Peak_aTF
% 
%
% Transfer Function Peak_aTF(s)
%
Peak_aTF = K*K3*FaTF*FlTF*feedback(STF*K1*FdTF,K2)                                  % DU*Sec^2/Meter
%
%
% Transfer Function Peak_ak(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Peak_ak(k) = 5.185e18*s/(s^12 + 94*s^11 + 3284*s^10 + 6.775e04*s^9 + 9.569e05*s^8 + 9.811e06*s^7 + 7.444e07*s^6 + 4.178e08*s^5 + 1.693e09*s^4 + 4.765e09*s^3 + 9.281e09*s^2 + 1.366e10*s + 8.223e08);
end
%
%
% Plot of the Transfer Function Flat_aTF
% Circular Frequency
hfig = figure;
loglog(fk,abs(Peak_ak),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (DU*s^2/m)');
title('Peak Aceleration Tranfer Function');
grid on;
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Peak_aTF.pdf');
%
%










%% Peak Velocity Transfer Function Peak_vTF
%
%
% Transfer Function Peak_vTF(s)
Peak_vTF = Peak_aTF*tf([1 0],[1])                                           % DU*Sec/Meter
%
%
% Transfer Function Peak_vk(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Peak_vk(k) = 5.185e18*s^2/(s^12 + 94*s^11 + 3284*s^10 + 6.775e04*s^9 + 9.569e05*s^8 + 9.811e06*s^7 + 7.444e07*s^6 + 4.178e08*s^5 + 1.693e09*s^4 + 4.765e09*s^3 + 9.281e09*s^2 + 1.366e10*s + 8.223e08);
end
%
%
% Plot of the Transfer Function
% Circular Frequency
hfig = figure;
loglog(fk,abs(Peak_vk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (DU*s/m)');
title('Peak Velocity Tranfer Function');
grid on;
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Peak_vTF.pdf');
%
%










%% Peak Displacement Transfer Function Peak_dTF
%
%
% Transfer Function Peak_dTF(s)
Peak_dTF = Peak_vTF*tf([1 0],[1])% DU*Sec/Meter
%
%
% Transfer Function Flat_dk(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Peak_dk(k) = 5.185e18*s^3/(s^12 + 94*s^11 + 3284*s^10 + 6.775e04*s^9 + 9.569e05*s^8 + 9.811e06*s^7 + 7.444e07*s^6 + 4.178e08*s^5 + 1.693e09*s^4 + 4.765e09*s^3 + 9.281e09*s^2 + 1.366e10*s + 8.223e08);
end
%
%
% Plot of the Transfer Function
% Circular Frequency
hfig = figure;
loglog(fk,abs(Peak_dk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (DU/m)');
title('Peak Tranfer Function (Displacement)');
grid on;
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Peak_dTF.pdf')
%
%










 
%% SP Seismometer is sensible to velocity.
% This seismometer is sensible to velocity
% 
% Equipment constant's
Rg = 1800;
Re = 2680;
G = Re/(Rg+Re);
G1 = 175;
G2 = 23700;















%% SP Sensor Transfer Function Sp
%
%
fSP = 1.0;
w0 = 2*pi*fSP;
hSP = 0.85;
%
%
% Transfer Function Sp(s)
SpTF = tf([1 0],[1 2*h*w0 (w0)^2])                              % Adimentional
%
%
% Transfer Function Sp(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Spk(k) = s^2/(s^2 + 2*h*w0+s+(w0)^2);                                                   % Adimentional
end
%
%
% Plot of the Transfer Function Sp
% Circular Frequency
hfig = figure;
loglog(fk,abs(Spk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Adimentional)');
title('SP Sensor Tranfer Function');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Sp.pdf');
%
%










%% Feedback Transfer Function Fb
%
%
wb = 0.314165;
%
%
% Transfer Function Fb(s)
FbTF = tf([1 0],[1 wb])                                                     % Adimentional
%
%
% Transfer Function Fb(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Fbk(k) = s/(s + wb);                                                   % Adimentional
end
%
%
% Plot of the Transfer Function Fb
% Circular Frequency
hfig = figure;
loglog(fk,abs(Fbk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Adimentional)');
title('1-st Order High Pass Filter Fb Tranfer Function');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Fb.pdf');
%
%










%% Low-Pass Antialiasing Filter Fp
%
%
wp = 57.1199;                                                               % Rad/Sec
%
%










%% Part A of the Filter Fp  (Fpa)
%
%
% Transfer Function Fpa(s)
FpaTF = tf([wp^2],[1 2*cos(pi/8)*wp wp^2])                                  % Adimentional
%
%
% Transfer Function Fpa(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Fpak(k) = wp^2/(s^2 + 2*cos(pi/8)*wp*s + wp^2);                         % Adimentional
end
%
%
% Plot of the Transfer Function Fla
% Circular Frequency
hfig = figure;
loglog(fk,abs(Fpak),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Adimentional)');
title('2-nd order low-pass Fpa filter');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Fpa.pdf');
%
%










%% Part A of the Filter Fp  (Fpb)
%
%
% Transfer Function Fpb(s)
FpbTF = tf([wp^2],[1 2*cos(3*pi/8)*wp wp^2])                                % Adimentional
%
%
% Transfer Function Fpb(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Fpbk(k) = wp^2/(s^2 + 2*cos(3*pi/8)*wp*s + wp^2);                       % Adimentional
end
%
%
% Plot of the Transfer Function Fpb
% Circular Frequency
hfig = figure;
loglog(fk,abs(Fpbk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Adimentional)');
title('2-nd order low-pass Fpb filter');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Fpb.pdf');
%
%










%% Complete Filter Fp
%
% Transfer Function Fp(s)
FpTF = (FpaTF)^2*(FpbTF)^2                                                  % Adimentional
%
%
% Transfer Function Fp(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Fpk(k) = 1.133e14/(s^8 + 298.5*s^7 + 4.456e04*s^6 + 4.299e06*s^5 + 2.908e08*s^4 + 1.403e10*s^3 + 4.743e11*s^2 + 1.037e13*s + 1.133e14);
end
%
%
% Plot of the Transfer Function Fp
% Circular Frequency
hfig = figure;
loglog(fk,abs(Fpk),'r');
xlim([0.005 20]);
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (Adimentional)');
title('8-th order low-pass Fp filter');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','TF_Fp.pdf');
%
%










%% Short Acceleration Transfer Function Short_aTF
% 
%
% Transfer Function Short_aTF(s)
Short_aTF = K*G*G1*G2*SpTF*FbTF*FpTF                                        % DU*Sec^2/Meter
%
%
% Transfer Function Peak_ak(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Short_ak(k) = 5.761e22*s^2/(s^11 + 309.5*s^10 + 4.788e04*s^9 + 4.802e06*s^8 + 3.399e08*s^7 + 1.741e10*s^6 + 6.411e11*s^5 + 1.619e13*s^4 + 2.478e14*s^3 + 1.696e15*s^2 + 4.982e15*s + 1.405e15);
end
%
%
% Plot of the Transfer Function Short_aTF
% Circular Frequency
hfig = figure;
loglog(fk,abs(Short_ak),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (DU*s^2/m)');
title('Short Aceleration Tranfer Function');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Short_aTF.pdf');
%
%










%% Short Velocity Transfer Function Short_vTF
%
%
% Transfer Function Short_vTF(s)
Short_vTF = Short_aTF*tf([1 0],[1])                                         % DU*Sec/Meter
%
%
% Transfer Function Peak_vk(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Short_vk(k) = 5.761e22*s^3/(s^11 + 309.5*s^10 + 4.788e04*s^9 + 4.802e06*s^8 + 3.399e08*s^7 + 1.741e10*s^6 + 6.411e11*s^5 + 1.619e13*s^4 + 2.478e14*s^3 + 1.696e15*s^2 + 4.982e15*s + 1.405e15);
end
%
%
% Plot of the Transfer Function
% Circular Frequency
hfig = figure;
loglog(fk,abs(Short_vk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (DU*s/m)');
title('Short Velocity Tranfer Function');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Short_vTF.pdf');
%
%










%% Short Displacement Transfer Function Short_dTF
%
%
% Transfer Function Short_dTF(s)
Short_dTF = Short_vTF*tf([1 0],[1])% DU*Sec/Meter
%
%
% Transfer Function Flat_dk(wk)
for k = 1:length(wk)
    s = i*wk(k);
    Short_dk(k) = 5.761e22*s^4/(s^11 + 309.5*s^10 + 4.788e04*s^9 + 4.802e06*s^8 + 3.399e08*s^7 + 1.741e10*s^6 + 6.411e11*s^5 + 1.619e13*s^4 + 2.478e14*s^3 + 1.696e15*s^2 + 4.982e15*s + 1.405e15);
end
%
%
% Plot of the Transfer Function
% Circular Frequency
hfig = figure;
loglog(fk,abs(Short_dk),'r');
xlabel('Cicular Frequency (HZ)');
ylabel('Transfer function (DU/m)');
title('Short Tranfer Function (Displacement)');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Short_dTF.pdf')
%
%










%% Plot of Sensitivity
% Circular Frequency
hfig = figure;
loglog(fk,0.01*abs(Flat_dk),'k',fk,0.01*abs(Peak_dk),'r',fk,0.01*abs(Short_dk),'b');
xlim([0.005 20]);
ylim([10^3 10^10]);
xlabel('Cicular Frequency (HZ)');
ylabel('Sensitivity (DU/cm)');
title('Apollo Seismometer Frequency Responses');
legend('Apollo-LP(Flat)','Apollo-LP(Peak)','Apollo-SP');
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Sensitivity.pdf')
%
%
%% Plot of the Transfer Function Fa
% preliminaries
% [svFa,wFa] = sigma(FaTF);
% fFa = wFa/(2*pi);
% Circular Frequency
% hfig = figure;
% loglog(fFa,svFa,'r');
% xlabel('Circular Frequency (HZ)');
% ylabel('Transfer function Fa (Adimentional)');
% title('1-st order hifh-pass Fa filter');
%
%