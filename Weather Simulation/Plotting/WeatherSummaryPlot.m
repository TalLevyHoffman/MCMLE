Pobs = [1 Data(1,:)];
RMSE = [0 Data(3,:)];
T95P = [0 Data(6,:)];

figure(); hold on;
plot(Pobs,T95P,'-*r','DisplayName','Upper 95%','LineWidth',3);
plot(Pobs,RMSE,'-*b','DisplayName','RMSE','LineWidth',3);
xlabel('p_{obs} [ ]');
ylabel('Rank Error [ ]');
grid on; box on;
legend('Location','Best');
xlim([0.5 1]);
ylim([0 3]);
