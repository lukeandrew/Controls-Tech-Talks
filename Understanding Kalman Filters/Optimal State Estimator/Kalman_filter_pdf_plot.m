hold off;
% Create model and measurement probability distributions
% first, Kalman Filter at step k-1
mu_kf_prev=7;   
sigma_kf_prev=0.25;
pd_kf_prev=makedist('Normal',mu_kf_prev,sigma_kf_prev);
% now, model at step k
mu_model=10;
sigma_model=1.7*sigma_kf_prev;
pd_model=makedist('Normal',mu_model,sigma_model);
% now measurement at step k
mu_meas=11;
sigma_meas=0.5;
pd_meas=makedist('Normal',mu_meas,sigma_meas);
% Calculate x vector to evaluate pdfs at
x=linspace(min(mu_kf_prev,mu_meas)-3.1*max(sigma_kf_prev,sigma_meas),max(mu_model,mu_meas)+3.1*max(sigma_model,sigma_meas),1000000);
% Sample and plot model pdf at previous step k-1
y_kf_prev=pdf(pd_kf_prev,x);
plot(x,y_kf_prev,'b','LineWidth',2);
hold on
% Sample and plot model pdf at currrent step
y_model=pdf(pd_model,x);
plot(x,y_model,'b','LineWidth',3);
% Sample and plot measurement pdf at current step
y_meas=pdf(pd_meas,x);
plot(x,y_meas,'Color',[0.87058824300766 0.490196079015732 0],'LineWidth',3);
% Compute and plot Kalman Filter pdf
y_kf=y_model.*y_meas;
y_kf_normalized=y_kf/(sum(y_kf)*(x(2)-x(1)));
plot(x,y_kf_normalized,'Color',[0.501960813999176 0.501960813999176 0.501960813999176],'LineWidth',3);
legend('Kalman Filter at step k-1','Model at step k', 'Measurement at step k','Kalman Filter at step k','Location','bestoutside');
xlabel('x');
ylabel('Probability Density Function');

