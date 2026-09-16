clear;
omegas=1;
omega=(0:.05:300)';
j=0;
for zeta=.1:.1:10
j=j+1;
PHI(:,j)=-omega.^2./(omega.^2-2*i*zeta*omega - omegas^2);
end
figure(1)
plot(omega,abs(PHI));
xlabel('\omega/\omega_s');
ylabel('| \PHI (\omega)|')
figure(2)
plot(omega,angle(PHI)*180/pi);
xlabel('\omega/\omega_s');
ylabel('\theta (\omega)')
