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

El calculo de distancias supone una Luna esferica
como se justifica en el documento:

	- Jet Propulsion Laboratory: Lunar Constants
	  and Models Document

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

MQ_Lat_Lon = [...% [Deg]
0048.0000	-035.0000;...	%N01 Nakamura
0042.0000	-024.0000;...	%N02 Nakamura
0043.0000	-047.0000;...	%N03 Nakamura (Oscar Arcila)
0054.0000	0101.0000;...	%N04 Nakamura
0012.0000	0046.0000;...	%N05 Nakamura
0037.2770	0042.9570;...	%N06 Watters
-012.1690	-074.4220;...	%N07 Watters
0033.0000	0035.0000;...	%N08 Nakamura
-084.0000	-134.0000;...	%N09 Nakamura
-008.0720	-074.3850;...	%N10 Watters
-016.8590	-033.5660;...	%N11 Watters
0036.0000	-016.0000;...	%N12 Nakamura
-048.0000	-106.0000;...	%N13 Nakamura
0020.0910	0030.9870;...	%N14 Watters (Santiago Ruiz)
-008.9754	0045.4981;...	%N15 Nakamura
0019.3900	0082.2300;...	%N16 Watters
0029.0000	-098.0000;...	%N17 Nakamura
0075.0000	0040.0000;...	%N18 Nakamura
-002.0000	-051.0000;...	%N19 Nakamura
0015.9600	-023.4870;...	%N20 Watters
-051.7680	-029.8120;...	%N21 Watters
0003.0000	-058.0000;...	%N22 Nakamura
0008.4200	0059.2490;...	%N23 Watters
0050.0000	0030.0000;...	%N24 Nakamura
0033.5760	0039.8010;...	%N25 Watters
0047.7460	-017.1770;...	%N26 Watters
-019.0000	0012.0000;...	%N27 Nakamura
0077.0000	-010.0000 ...	%N28 Nakamura
];

ST_Lat_Lon = [...% [Deg]
-003.0094	-023.4246;...	%ST12
-003.6440	-017.4775;...	%ST14
0026.1341	0003.6298;...	%ST15
-008.9754	0015.4981 ...	%ST16
];

for ii = 1:length(ST_Lat_Lon)
	for jj = 1:length(MQ_Lat_Lon)
		R(jj,ii) = MoonDistance(MQ_Lat_Lon(jj,1),MQ_Lat_Lon(jj,2),ST_Lat_Lon(ii,1),ST_Lat_Lon(ii,2));
	end
end

function [R] = MoonDistance(La1,Lo1,La2,Lo2)

Radio=	1737.4;% [KM]

La_r1= La1*pi/180;% [rad]
La_r2= La2*pi/180;% [rad]

delta_Lo_r= (Lo2-Lo1)*pi/180;% [rad]

R = round(acos(sin(La_r1)*sin(La_r2)+cos(La_r1)*cos(La_r2)*cos(delta_Lo_r))*Radio);% [KM]

end