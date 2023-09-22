%% Main code
clear 
clc
close all

% Parameters are loading
parameters

Vplot    = zeros(simCtr,1);
tplot    = zeros(simCtr,1);
Idplot   = zeros(simCtr,1);
% comment line 13,14,15,16,31,32 and 33 for measuring computing time
% Loops=1000;                           
% ElapsedTime=zeros(Loops,1); 
% for j=1:Loops
% tic

for i=1:simCtr
    Vplot(i) = V;
    tplot(i) = time;
    Vdot     = mathmodel(R,C,Vp,w,Is,Vt,n,V,time);
    [V,time] = integration(V,Vdot,R,C,Vp,w,Is,Vt,n,time,gamma,deltat);

    if Vp*sin(time*w)<0
         Idplot(i)=-(C*Vdot+V/R);
    else
         Idplot(i)=+(C*Vdot+V/R);
    end
end

% ElapsedTime(j,1)=toc;
%end
% AverageTime=mean(ElapsedTime);

%simulink part
out=sim('SimulationFullwave',simTime);

figure(1)
plot(out.tout(:,end), out.InputCurrent(:,end),LineWidth=2,Color='k',LineStyle='-')
hold on
plot(tplot, Idplot,LineWidth=2,Color='r',LineStyle='-')
grid on
axis([0 0.1 -2 2])
set(gca,'FontSize',20)
fontname(gca,"Times New Roman")
%Adding legends
legend('SimulinkModel', 'Method X')

% Adding labels and title
xlabel('Time (s)')
ylabel('Current (A)')
title('Input Current Simulation Results')

figure(2)
plot(out.tout(:,end),out.OutputVoltage(:,end),LineWidth=2,Color='k',LineStyle='-')
hold on
grid on
plot(tplot,Vplot,LineWidth=2,Color='r',LineStyle='--')
%plot(tplot,Vp*sin(tplot.*w),LineWidth=2,Color='g')                          % Comment Line 59 if you want input voltage
axis([0 0.1 0 200])
% Adding legends
legend('SimulinkModel', 'Method X')

% Adding labels and title
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Output Voltage Simulation Results')
set(gca,'FontSize',20)
fontname(gca,"Times New Roman")

% relative rms error calculation

simulink_current=out.InputCurrent(:,end);
method_current=Idplot;

Xrms=rms(simulink_current);
ns=simCtr;
e_tk_square=(out.InputCurrent(:,end)-Idplot)'*(out.InputCurrent(:,end)-Idplot);

e_rms=1/Xrms*sqrt(1/ns*e_tk_square);
