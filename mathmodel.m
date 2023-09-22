function Vdot = mathmodel(R,C,Vp,w,Is,Vt,n,V,time)
Vdot=-V*(1/(R*C))+(Is/C)*(exp(((abs(Vp*sin(time*w))-V)/(n*Vt))-1));
end