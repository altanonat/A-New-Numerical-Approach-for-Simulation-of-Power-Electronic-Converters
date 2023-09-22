% Define the parameters of full-wave rectifier and initial conditions
f  = 50;
R  = 300;
C  = 28e-6;
Vp = 180;
w  = 2*pi*f;
Is = 1e-14;
Vt = 25.8e-3;
n  = 1;

simTime = 0.1;
deltat  = 1e-6;
simCtr  = round(simTime/deltat)+1;

V        = 0;
time     = 0;

% Parameter for TR BDF2 method
% gamma   = 2-sqrt(2); % L-Stable Value
gamma   = 0.5; % A-stable value