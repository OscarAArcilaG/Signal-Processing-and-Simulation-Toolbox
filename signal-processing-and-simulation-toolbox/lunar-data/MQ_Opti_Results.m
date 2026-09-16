close all;
clearvars;
clear global;
warning off;
dbstop if error;
clc;


%{
La medicion de distancias se basa en el archivo:

"MoonDistance.m"

este archivo fue suministrado por Santiago Ruiz


se supone que:
	N	norte	corresponde a latitud positiva
	S	sur 	corresponde a latitud negativa
	E	este	corresponde a longitud positiva
	W	oeste	corresponde a longitud negativa
	
	
el software calcula distancias entre dos puntos
a partir de las coordenadas (Latitud,Longitud)

	distancia = MoonDistance(Lat1,Lon1,Lat2,Lon2);
	
	
MQ contiene las localizaciones de los eventos

	MQ(:,1) = Shallow MQ N#
	MQ(:,2) = Shallow localizacion Latitud
	MQ(:,3) = Shallow localizacion Longitud
	
	datos tomados de dos fuentes:
	
	-Thomas R. Watters Shallow seismic activity and
	young thrust faults on the Moon
	(SUPPLEMENTARY INFORMATION)
	
	-Yosio Nakamura Shallow MoonQuakes: Depth,
	distribution and implications as to the
	present state of the lunar interior
	
	Siempre que esten disponibles se prefieren las
	locaciones suministradas por Watters
	
	para aquellos eventos no considerados por Watters
	o que no se logro determinar una ubicacion especifica
	se emplea la ubicacion suministrada por Nakamura
	
	las locaciones marcadas como "Santiago Ruiz"
	se obtuvieron a partir de las locaciones suministradas
	por "Watters" pero debido a la multiplicidad de coordenadas
	Santiago eligio segun su criterio


ST contiene las coordenadas de
las estaciones PSE del Apollo

	ST(:,1) = Apollo PSE station #
	ST(:,2) = station Latitud
	ST(:,3) = station Longitud
	
	datos tomados de:
	
	R. Yamada The description of
	Apollo seismic experiments

%}


SM = [...%Seismic Moment
4.40E+14;...%N01	
6.60E+13;...%N02	
5.20E+13;...%N03	
2.30E+14;...%N04	
1.10E+13;...%N05	
1.90E+13;...%N06	
1.20E+13;...%N07	
5.50E+12;...%N08	
6.60E+14;...%N09	
1.30E+14;...%N10	
3.40E+13;...%N11	
4.70E+12;...%N12	
1.50E+13;...%N13	
1.00E+13;...%N14	
6.30E+13;...%N15	
2.50E+14;...%N16	
1.60E+15;...%N17	
1.10E+14;...%N18	
1.00E+13;...%N19	
1.90E+13;...%N20	
2.90E+13;...%N21	
2.30E+13;...%N22	
4.80E+13;...%N23	
4.20E+13;...%N24	
1.10E+14;...%N25	
3.00E+14;...%N26	
5.60E+13;...%N27	
1.30E+13;...%N28	
];



MQ_Lat_Lon = [...% [Deg]
0048.0000	-035.0000;...	%Nakamura
0042.0000	-024.0000;...	%Nakamura
0043.0000	-047.0000;...	%Oscar Arcila (Nakamura)
0054.0000	0101.0000;...	%Nakamura
0012.0000	0046.0000;...	%Nakamura
0037.2770	0042.9570;...	%Watters
-012.1690	-074.4220;...	%Watters
0033.0000	0035.0000;...	%Nakamura
-084.0000	-134.0000;...	%Nakamura
-008.0720	-074.3850;...	%Watters
-016.8590	-033.5660;...	%Watters
0036.0000	-016.0000;...	%Nakamura
-048.0000	-106.0000;...	%Nakamura
0020.0910	0030.9870;...	%Santiago Ruiz (Watters)
-008.9754	0045.4981;...	%Nakamura
0019.3900	0082.2300;...	%Watters
0029.0000	-098.0000;...	%Nakamura
0075.0000	0040.0000;...	%Nakamura
-002.0000	-051.0000;...	%Nakamura
0015.9600	-023.4870;...	%Watters
-051.7680	-029.8120;...	%Watters
0003.0000	-058.0000;...	%Nakamura
0008.4200	0059.2490;...	%Watters
0050.0000	0030.0000;...	%Nakamura
0033.5760	0039.8010;...	%Watters
0047.7460	-017.1770;...	%Watters
-019.0000	0012.0000;...	%Nakamura
0077.0000	-010.0000 ...	%Nakamura
];

ST_Lat_Lon = [...% [Deg]
12	-003.0094	-023.4246;...
14	-003.6440	-017.4775;...
15	0026.1341	0003.6298;...
16	-008.9754	0015.4981 ...
];


matdr = dir(fullfile(pwd,'Save_*.mat'));
matA = {'filename','fh','zh','fg','zg','%N01','expo01','%N02','expo03','N','fs','PGA','Mw','R'};
excelfilename = 'MQ_Opti_Results.xlsx';
writecell(matA,excelfilename,'Sheet',1,'Range','A1');
for ii = 1:length(matdr)
	matfilename = matdr(ii).name;
	Mw = 2/3*(log10(SM(str2double(matfilename(11:12)),1))-9.05);
	ST_Idx = find(ST_Lat_Lon(:,1)==str2double(matfilename(16:17)));
	R = MoonDistance(MQ_Lat_Lon(str2double(matfilename(11:12)),1),MQ_Lat_Lon(str2double(matfilename(11:12)),2),...
	ST_Lat_Lon(ST_Idx,2),ST_Lat_Lon(ST_Idx,3));
	load(matfilename);
	matA = {matfilename,BestVect(end,:),optiWSVec(end,1)*100/N,optiWSVec(end,2),optiWSVec(end,3)*100/N,optiWSVec(end,4),N,fs,max(abs(mq)),Mw,R};
	matRange =['A' num2str(str2double(matfilename(6:8))+1)];
	excelfilename = 'MQ_Opti_Results.xlsx';
	writecell(matA,excelfilename,'Sheet',1,'Range',matRange);
	Results(str2double(matfilename(6:8)),:) = [str2double(matfilename(6:8)),BestVect(end,:),optiWSVec(end,1)*100/N,optiWSVec(end,2),optiWSVec(end,3)*100/N,optiWSVec(end,4),N,fs,max(abs(mq)),Mw,R];
end
save("SwarmResults.mat","Results");

function [R] = MoonDistance(La1,Lo1,La2,Lo2)

Radio=	1737.4;% [KM]

La_r1= La1*pi/180;% [rad]
La_r2= La2*pi/180;% [rad]

delta_Lo_r= (Lo2-Lo1)*pi/180;% [rad]

R = round(acos(sin(La_r1)*sin(La_r2)+cos(La_r1)*cos(La_r2)*cos(delta_Lo_r))*Radio);% [KM]

end