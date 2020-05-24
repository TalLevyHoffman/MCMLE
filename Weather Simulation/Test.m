clc;
clear;
close all;

global Q
Q = 1.4;

pObs = 0.5;
Iterations = 75;
RankType = 'MCMLE';
SavePath = ['Output\pObs ' num2str(pObs)];
DataPath = 'DB\Processed';

WeatherIterations(pObs,Iterations,RankType,SavePath,DataPath);

[N, R, T] = xlsread([SavePath '\FullRanking.xlsx']);

Ref = N(:,1)*ones(1,Iterations);
Est = N(:,2:Iterations+1);

vSTD = std(Est,[],2);
AbsErr = abs(Ref-Est);

STD = mean(vSTD)
RMSE = mean(mean(AbsErr.^2))
Err95 = prctile(AbsErr(:),95)