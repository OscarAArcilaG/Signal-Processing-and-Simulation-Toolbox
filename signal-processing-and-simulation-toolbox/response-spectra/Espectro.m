clc,clear,close
%% Espectro de respuesta
global ti
m=1;zeta=5/100;fm=50;
periodos=logspace(-2,1,1000);
Record = load('elcentro.txt')/(9.81*100);
ti=Record;
ResD=zeros;ResV=zeros;ResA=zeros;ResSV=zeros;ResSA=zeros;
ER={zeros};
for j=1:length(periodos)
    tn=periodos(j);
    wn=2*pi/tn;c=2*m*zeta*wn;k=wn^2;
    [u,v,a]=interpolation(m,c,k,-Record,0,0,1/fm);
    D=max(abs(u));V=max(abs(v));A=max(abs(a));
    SV=(2*pi/tn)*D;SA=((2*pi/tn)^2)*D;
    ResD(j)=D;ResV(j)=V;ResA(j)=A;
    ResSV(j)=SV;ResSA(j)=SA;
end
ER{1}=ResD;ER{2}=ResV;ER{3}=ResA;ER{4}=ResSV;ER{5}=ResSA;
%%
for i=1:5
    figure
    semilogx(periodos,ER{i});plottools;
    gfs=gca;
    gfs.XLabel.String= "Tn [s]";gfs.XLabel.FontWeight= 'bold';
    switch (i)
        case 1
            gfs.YLabel.String= "D=uo [g*s^2]";gfs.YLabel.FontWeight= 'bold';
            title('Espectro de respuesta en desplazamiento')
        case 2
            gfs.YLabel.String= "Vo [g*s]";gfs.YLabel.FontWeight= 'bold';
            title('Espectro de respuesta en velocidad')
        case 3
            gfs.YLabel.String= "üo [g]";gfs.YLabel.FontWeight= 'bold';
            title('Espectro de respuesta en aceleración ')
        case 4
            gfs.YLabel.String= "SV [g*s]";gfs.YLabel.FontWeight= 'bold';
            title('Espectro de respuesta en pseudo-velocidad')
        case 5
            gfs.YLabel.String= "SA [g]";gfs.YLabel.FontWeight= 'bold';
            title('Espectro de respuesta en pseudo-aceleración')
    end
    grid minor
end