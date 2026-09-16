% Vector of Frequencies
dfk = 0.00001;
fk = 0.01:dfk:10;
wk = 2*pi*fk;
% Peak Acceleration Transfer Function Peak_aTF
% 
%
% Transfer Function Peak_aTF(s)
%
%Peak_aTF = K*K3*FaTF*FlTF*feedback(STF*K1*FdTF,K2)                                  % DU*Sec^2/Meter
%
%
% Transfer Function Peak_ak(wk)
for k = 1:length(wk)
    s = 1i*wk(k);
    Peak_ak(k) = 5.185e18*s/(s^12 + 94*s^11 + 3284*s^10 + 6.775e04*s^9 + 9.569e05*s^8 + 9.811e06*s^7 + 7.444e07*s^6 + 4.178e08*s^5 + 1.693e09*s^4 + 4.765e09*s^3 + 9.281e09*s^2 + 1.366e10*s + 8.223e08);
end
% Plot of the Transfer Function Flat_aTF and WL
hfig = figure;
p1 = semilogx(fk,db(abs(Peak_ak)),LineWidth=1, Color='r');
hold on;
p2 = yline(db(abs(Peak_ak(1)))-3,LineWidth=1, Color='k',LineStyle='-.');
p3 = yline(db(0.1*max(abs(Peak_ak))),LineWidth=1, Color='b',LineStyle='--');
hold off;
xlabel('Frequency (Hz)');
ylabel('Transfer function (DB[DU*s^2/m])');
title('Peak Aceleration Tranfer Function:','BandWidth and Water Level');
legend([p1,p2,p3],{'Peak Acc TF','BandWidth','Water Level k = 0.1'},Location="southwest");
grid on;
set(hfig,'PaperOrientation','landscape');
grid on;
print(hfig,'-bestfit','-dpdf','Peak_aTF_WL.pdf');