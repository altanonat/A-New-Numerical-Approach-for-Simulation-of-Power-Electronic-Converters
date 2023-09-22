function [x,time] = integration(x,xp,R,C,Vp,w,Is,Vt,n,time,gamma,deltat)  % choose one of the methods presented here.

% TR BDF2 Method
timeg   = time+gamma*deltat;
xkg     = x+gamma*deltat*xp;
fkgamma = mathmodel(R,C,Vp,w,Is,Vt,n,xkg,timeg);
%fkgamma = (fkgamma+xp)/2;                           % Comment line 6 for Improved-TR-BDF2, Uncomment line 6 for classic TR-BDF2                            
xkgamma = x+gamma*(deltat/2)*(xp+fkgamma);

time = time+deltat;
x1   = x+deltat*xp;
fk1  = mathmodel(R,C,Vp,w,Is,Vt,n,x1,time);
%fk1  = (fk1+xp)/2;                                  % Comment line 13 for Improved-TR-BDF2, Uncomment line 13 for classic TR-BDF2 
x    = (1/(gamma*(2-gamma)))*xkgamma-(((1-gamma)^2)/(gamma*(2-gamma)))*x+((1-gamma)/(2-gamma))*deltat*fk1;

% Predictor Corrector
% time  = time+deltat;
% xi    = x+deltat*xp;
% ftiwi = mathmodel(R,C,Vp,w,Is,Vt,n,xi,time);
% ftiwi = (ftiwi+xp)/2;                              % Comment line 19 for Improved PC, Uncomment line 19 for classic PC
% xi1p  = x+(deltat/2)*(3*ftiwi-xp);
% xp1   = mathmodel(R,C,Vp,w,Is,Vt,n,xi1p,time);
% xp1    = (xp1+ftiwi)/2;                            % Comment line 22 for Improved PC, Uncomment line 22 for classic PC
% x     = x+(deltat/2)*(ftiwi+xp1);

% Runge Kutta 4
% tempx = x;
% k1    = deltat*xp;
% x     = tempx+0.5*k1;
% time  = time+0.5*deltat;
% xp    = mathmodel(R,C,Vp,w,Is,Vt,n,x,time);
% 
% k2 = deltat*xp;
% x  = tempx+0.5*k2;
% xp = mathmodel(R,C,Vp,w,Is,Vt,n,x,time);
% 
% k3   = deltat*xp;
% x    = tempx+k3;
% time = time+0.5*deltat;
% xp   = mathmodel(R,C,Vp,w,Is,Vt,n,x,time);
% 
% k4 = deltat*xp;
% x  = tempx+(1/6)*(k1+2*k2+2*k3+k4);
% end