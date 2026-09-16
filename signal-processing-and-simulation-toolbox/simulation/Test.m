close all;
clear all;
clc;
warning off;
global fs N winN
diary Log.txt;
root = pwd;
mkdir Plot;
cd Data;
dr = dir('Acc-N*.txt');
%    fl    zl    fg    zg
p = [0.362 0.425 0.705 0.084];
for ii = 1:length(dr)
	if dr(ii).isdir == 0
		filenametxt = dr(ii).name;
		filename = filenametxt(1:end-4);
		fileID = fopen(filenametxt);
		Dat = cell2mat(textscan(fileID,'%f %f','headerlines',15));
		fclose(fileID);
		tt = Dat(:,1);
		mq = Dat(:,2);
		try
			fs = 1/mean(diff(tt));
			[b,a] = butter(8,[0.05 0.80]/(fs/2),'bandpass');
			mq = filtfilt(b,a,mq);
			N = length(mq);
			T = tt(end);
			mqN = mq/max(abs(mq));
			ttN = tt/T;
			[psdmqN,ffmqN] = psdCalc(mqN,N,fs);
			[~,winN,~,~,~,~] = WinCalc(ttN,mqN);
			[ttS,mqSN] = Generate(p);
			NS = length(mqSN);
			[psdSN,ffSN] = psdCalc(mqSN,NS,fs);
			TS = ttS(end);
			ttSN = ttS/TS;
			hfig = figure('Visible','off','units','normalized','outerposition',[0 0 1 1]);
			set(gcf,'Color','k','inverthardcopy','off');
			subplot(2,1,1);
			plot(ttN,mqN,'Color',[0.8500, 0.3250, 0.0980]);
			grid on;
			hold on;
			p1 = plot(ttN,winN,'linewidth',2,'Color',[0.0000, 0.4470, 0.7410]);
			hold off;
			set(gca,'Color','k','YColor','w','XColor','w','GridColor','w');
			axis([0 1 -1.1 1.1]);
			subplot(2,1,2);
			p1 = semilogx(ffmqN,db(psdmqN),'linewidth',2,'Color',[0.8500, 0.3250, 0.0980]);
			grid on;
			hold on;
			p2 = plot(ffSN,db(psdSN),'linewidth',2,'Color',[0.0000, 0.4470, 0.7410]);
			hold off;
			set(gca,'Color','k','YColor','w','XColor','w','GridColor','w');
			axis([0.05 3.5 20*floor(min(db(psdmqN))/20-1) 20*ceil(max(db(psdmqN))/20+1)]);
			oldunits = hfig.Units;
			set(gcf, 'PaperUnits', 'centimeters', 'Units', 'centimeters');
			figpos = get(gcf, 'Position');
			set(gcf, 'PaperSize', figpos(3:4), 'Units', oldunits);
			print('-f1','-image','-r0',[root '\Plot\' filename],'-djpeg');
			close (gcf);
		catch
			filename
		end
	end
end
beep;	
diary off;


function [psd,ff] = psdCalc(mq,N,fs)
	nfft = 2^(nextpow2(N)-6);
	noverlap = nfft/2;
	window = nfft;
	[psd,ff] = pwelch(mq,nfft,noverlap,window,fs);
end	


function [envN,winN,optiw01,optiw03,lbw,ubw] = WinCalc(tt,mq)
	N = length(mq);
	[env,~] = envelope(mq,round(N/40),'rms');
	envN = env/max(env);
	lbw01 = [round(0.05*N) 0.1];%[N01 expo01]
	ubw01 = [round(0.20*N) 5.0];
	nvarsw01 = length(lbw01);
	optionsw01 = optimoptions(@particleswarm,'Display','off','FunctionTolerance',1e-6);
    contw01 = 0;
	p_optw01 = particleswarm(@CostW01,nvarsw01,lbw01,ubw01,optionsw01);
	win01 = win01(:);
	lbw03 = (p_optw01(1) + 2);%N02
	ubw03 = round(0.40*N);
	nvarsw03 = length(lbw03);
	optionsw03 = optimoptions(@particleswarm,'Display','off','FunctionTolerance',1e-6);
    contw03 = 0;
	p_optw03 = particleswarm(@CostW03,nvarsw03,lbw03,ubw03,optionsw03);
	win03 = win03(:);
	n02 = N - length(win01) - length(win03);
	win02 = ones(n02,1);
	winN = [win01; win02; win03];
	lbw = [lbw01 lbw03];
	ubw = [ubw01 ubw03];
	
	function objw01 = CostW01(pw01)
		contw01 = contw01 +1;
		N01 = floor(pw01(1));
		n01 = N01;
		expo01 = pw01(2);
		win01 = ((1:n01)/n01).^expo01;
		win01 = win01(:);
		env01 = envN(1:n01);
		objw01 = goodnessOfFit(env01,win01,'NRMSE');
		optiw01(contw01,:) = [N01 expo01 objw01];
	end

	function objw03 = CostW03(pw03)
		contw03 = contw03 +1;
		N02 = ceil(pw03(1));
		N03 = N;
		ttw03 = tt(N02:N03)-tt(N02);
		env03 = envN(N02:N03);
		alpha = fit(ttw03,env03,'exp1','Lower',[1 -Inf],'Upper',[1 Inf]);
		expo03 = alpha.b;
		n03 = N03 - N02 + 1;
		win03 = exp(expo03*(tt(N03) - tt(N02))/(n03 - 1)*(1:n03));
		win03 = win03(:);
		objw03 = goodnessOfFit(env03,win03,'NRMSE');
		optiw03(contw03,:) = [N02 expo03 objw03];
	end	

end


function [ttS,mqSN] = Generate(p)
	global fs N winN
    ttS = 1/fs*(0:(N-1)).';
    rng('default');
    RanAcc = randn(1,N);
	fh = p(1);
	wh = fh*2*pi;
	zh = p(2);
	fg = p(3);
	wg = fg*2*pi;
	zg = p(4);
	numeq = conv([1 0],[2*zg*wg wg^2]);
	deneq = conv([1 2*zh*wh wh^2],[1 2*zg*wg wg^2]);
	H = tf(numeq,deneq);
	GenAcc = lsim(H,RanAcc,ttS);
	mqS = GenAcc.*winN;
	mqSN = mqS/max(abs(mqS));
end