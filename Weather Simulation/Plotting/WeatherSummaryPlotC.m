Pobs_MCMLE = [1 DataMCMLE(1,:)];
RMSE_MCMLE = [0 DataMCMLE(3,:)];
T95P_MCMLE = [0 DataMCMLE(6,:)];
Pobs_SMLE = [1 DataSMLE(1,:)];
RMSE_SMLE = [0 DataSMLE(3,:)];
T95P_SMLE = [0 DataSMLE(6,:)];

figure(); hold on;
plot(Pobs_MCMLE,T95P_MCMLE,'-*r','DisplayName','MCMLE: Upper 95%','LineWidth',3);
plot(Pobs_MCMLE,RMSE_MCMLE,'-*b','DisplayName','MCMLE: RMSE','LineWidth',3);
plot(Pobs_SMLE,T95P_SMLE,'--dr','DisplayName','SMLE: Upper 95%','LineWidth',3);
plot(Pobs_SMLE,RMSE_SMLE,'--db','DisplayName','SMLE: RMSE','LineWidth',3);
xlabel('p_{obs} [ ]');
ylabel('Rank Error [ ]');
grid on; box on;
legend('Location','Best');
xlim([0.5 1]);
ylim([0 5]);
