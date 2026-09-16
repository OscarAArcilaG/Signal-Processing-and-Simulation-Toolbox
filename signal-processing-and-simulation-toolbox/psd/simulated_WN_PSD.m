close all
clear all
clc
iter = 0;
for i = 0:5
	iter = iter +1;
	L = 10^i;
	N = 1024;
    rng('default');
	x = 2*randn(N,L);
	fvec = [0:N-1]/N;
	y = 1/sqrt(N)*fft(x);
    y2 = y.*conj(y);
    if i == 0
        z = y2';
    else
        z = mean(y2');
    end
    hfig = figure('units','normalized','outerposition',[0 0 1 1]);
	set(gcf,'Color','k','inverthardcopy','off');
	p1 = plot(fvec,db(z),'linewidth',2);
	set(gca,'Color','k','YColor','w','XColor','w','GridColor','w');
	ylim([0 20]);
    grid on;
	ylabel('Power Spectral Density [dB/Hz]','fontsize',12,'FontWeight','bold');
	xlabel('Normalized Frequency [-]','fontsize',12,'FontWeight','bold');
	title_str = ['Simulated PSD of WN from BLWN Ensemble'];
	ttl = title(title_str,'fontsize',15,'FontWeight','bold');
	set(ttl,'Color','w');
	legend_str = ['Ensemble size = ',num2str(L)];
	lgd = legend([p1],{legend_str},'fontsize',15,'FontWeight','bold','Orientation','horizontal');
	set(lgd,'TextColor','w');
	filename_str = [num2str(iter),' L ',num2str(L),'.jpg'];
	saveas(hfig,filename_str);                
	close (gcf);
end