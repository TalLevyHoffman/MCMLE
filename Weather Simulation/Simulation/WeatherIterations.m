function WeatherIterations(pObs,Iterations,RankType,SavePath,DataPath)

RefPath = [DataPath '\Ranking.xlsx'];

Ranking = nan(45,Iterations);

for i = 1 : 1 : Iterations
   
    CRanking = GetRank(pObs,RankType,'Weather', DataPath);
    
    Ranking(:,i) = cell2mat(CRanking(:,2));
    
    disp(['i = ' num2str(i)]);    
    
end

[~,~,RefData] = xlsread(RefPath); RefData = RefData';
RefData = RefData(:, 1:2);

RefDataMat  = cell2mat(RefData(:,2))*ones(1,Iterations);
DiffDataMat = abs(Ranking - RefDataMat);
MaxVec      = max(DiffDataMat,[],2);
MedianVec   = median(DiffDataMat,2);
ModeVec     = mode(Ranking,2);

for k = 1 : 1 : size(RefData,1)
   
    RefData(k,1) = strrep(RefData(k,1),'''','');
    
end

Data = [RefData num2cell([Ranking ModeVec MedianVec MaxVec])];

Headers = {'State','All Observed'};

for k = 1 : 1 : Iterations
    
    Headers = [Headers {['I' num2str(k)]}]; %#ok<AGROW>
    
end

Headers = [Headers {'Mode'}];
Headers = [Headers {'Median Difference'}];
Headers = [Headers {'Max Difference'}];

Data = [Headers ; Data];

if ~exist(SavePath,'dir')
    mkdir(SavePath);
end

SavePath = [SavePath '\FullRanking.xlsx'];

xlswrite(SavePath,Data);

end