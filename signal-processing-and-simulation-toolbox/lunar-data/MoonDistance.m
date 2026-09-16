function [d]=MoonDistance(La1,Lo1,La2,Lo2)

R=	1737.4*1000;

if La1=='s'
    La1=20.18935;

end
if Lo1=='s'
    Lo1=30.76796;
end
if La2=='s'
    La2=20.18935;

end
if Lo2=='s'
    Lo2=30.76796;
end

La_r1= La1*pi/180;
La_r2= La2*pi/180;

delta_Lo= (Lo2-Lo1)*pi/180;

d = (acos(sin(La_r1)*sin(La_r2) + cos(La_r1)*cos(La_r2) * cos(delta_Lo) ) * R)/1000;
end