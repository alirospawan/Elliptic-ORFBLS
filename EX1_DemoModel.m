clear all; clc; 
clf;

load EX1_SISO_IEllipticORFBLS.mat
y_Ellip= y;

% find the performance index
e_y=abs(sp(1:T)'-y(1:T));
maxE_y=max(e_y);
rmse_y=sqrt((e_y*e_y')/T);
ISE_y=sum(e_y*e_y');
IAE_y=sum(e_y);

for ttt=1:T
    xx(ttt)=ttt*e_y(ttt);
end
ITAE_y=sum(xx);

fprintf('maxError: %.4f\n', maxE_y);
fprintf('RMSE: %.4f\n', rmse_y);
fprintf('ISE: %.4f\n', ISE_y);
fprintf('IAE: %.4f\n', IAE_y);
fprintf('ITAE: %.4f\n', ITAE_y);


tvec=1:T;

figure(1);
% subplot(211)
plot(tvec,y(1:T),'r',tvec,sp(1:T),'b:')
% title('SETPOINT -- sp (blue...)  &  PLANT OUTPUT -- y (red)')
xlabel('sampling number');
ylabel('sp & y');
legend('PLANT OUTPUT','SETPOINT','Location','southeast')

figure(2);
plot(tvec,ym_id(1:T),'b', tvec,ym(1:T),'r'); xlabel('sampling number');ylabel('y');
% title('y compare')
legend('y identifier','y controller')


load EX1_SISO_CONV_PID.mat
load EX1_SISO_RFBLS_APPID.mat
y_rfbls_appid=y;
load EX1_SISO_ORFBLS_APPID.mat
load EX1_SISO_RFBLS_CONTROLLER.mat
y_rfblsC = y;
load EX1_SISO_ORFBLS_CONTROLLER.mat



figure(3);
plot(tvec,sp(1:T),'k:', tvec,y_conv_pid(1:T),'k', tvec,y_rfbls_appid(1:T),'y', tvec,y_orfbls_appid(1:T),'m', tvec,y_rfblsC(1:T),'b', tvec,y_orfbls_controller(1:T),'g', tvec,y_Ellip(1:T),'r')
xlabel('Sampling number');
ylabel('SP & Y');
legend('Setpoint','Conventional PID','RFBLS-APPID','ORFBLS-APPID','RFBLS Controller','ORFBLS Controller','Ellip ORFBLS','location','northwest','FontSize',6.5)

axes('position',[.45 .200 .23 .35],'ylabel',[])
box on % put box around new pair of axes

plot(tvec(550:700), sp(550:700), 'black:', ...
     tvec(550:700), y_conv_pid(550:700), 'black', ...
     tvec(550:700), y_rfbls_appid(550:700), 'y', ...
     tvec(550:700), y_orfbls_appid(550:700), 'm', ...
     tvec(550:700), y_rfblsC(550:700), 'b', ...
     tvec(550:700), y_orfbls_controller(550:700), 'g', ...
     tvec(550:700), y_Ellip(550:700), 'r');
axis tight

