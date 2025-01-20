clear all; clc; 
clf;

load EX2_SISO_IEllipticORFBLS.mat

% find max_error & RMSE
e_y=abs(sp(1:T)-yP(1:T));
maxE_y=max(e_y);
rmse_y=sqrt((e_y*e_y')/T);
ISE_y=e_y*e_y';
IAE_y=sum(e_y);

for ttt=1:size(e_y',1)
    xx(ttt)=ttt*e_y(ttt);
end
ITAE_y=sum(xx);

fprintf('maxError: %.4f\n', maxE_y);
fprintf('RMSE: %.4f\n', rmse_y);
fprintf('ISE: %.4f\n', ISE_y);
fprintf('IAE: %.4f\n', IAE_y);
fprintf('ITAE: %.4f\n', ITAE_y);

% plot
tvec=1:T;

figure(1);
% subplot(211)
plot(tvec,yP(1:T),'r',tvec,sp(1:T),'black:')
xlabel('Sampling Number'); ylabel('Temperature (°C)');
legend('y','r','location','southeast')


figure(2);
plot(tvec,ym_id(1:T),'b',tvec,ym(1:T),'r'); xlabel('sampling number'); ylabel('ŷ');
legend('y identifier','y controller','location','northeast')

eORFBLS = yP(1:T);


load CFMFAC_LSTM_SystemOutput.mat

% Plot the data
figure(3);
plot(time,sp,'k:', time,pid,'k', time,cfmac,'m', time,cfmac_bp,'b', time,cfmac_lstm,'g', time,eORFBLS,'r')
xlabel('Sampling Number'); ylabel('Sp & Y');
legend('Setpoint','PID','SISO-CFMFAC','SISO-CFMFAC-BP','SISO-CFMFAC-LSTM','Ellip ORFBLS','location','northeast')

% Add labels and legend
xlabel('Time [s]');  ylabel('Output (y)');
legend show;
grid on;
hold off;