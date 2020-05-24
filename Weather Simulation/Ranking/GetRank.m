function [Ranking,R] = GetRank(pObs,RankType,SymType,Path,RMax)

if nargin < 1
    
    pObs = 0.7;
    
end

if nargin < 2
    
    RankType = 'MCMLE';
    
end

if nargin < 3
    
    SymType = 'None';
    
end

if nargin < 5
    
    RMax = -1;
    
end

if (strcmp(SymType,'Weather'))
    
    LinesToRemove = 36;
    
else if (strcmp(SymType,'Football'))
        
        LinesToRemove = 37;
        
    else
        
        LinesToRemove = [];
        
    end
    
end

WeightPath = fullfile(Path,'WeightsI.xlsx');
NGamesPath = fullfile(Path,'NGames.xlsx');
RatioPath  = fullfile(Path,'Ratio.xlsx');
MatchPath  = fullfile(Path,'Match.xlsx');
ProbPath   = fullfile(Path,'Probability.xlsx');

[Wtt,T,~] = xlsread(WeightPath,'W');
[NG,~,~]  = xlsread(NGamesPath,'L');
[M,~,~]   = xlsread(RatioPath,'R');
[P,~,~]   = xlsread(ProbPath,'P');
[G,~,~]   = xlsread(MatchPath,'Match'); %#ok<ASGLU>

SC = nansum(M,1);

if isempty(LinesToRemove)
    LinesToRemove = find(SC == 1);
end

P(:,LinesToRemove) = [];
P(LinesToRemove,:) = [];

M(:,LinesToRemove) = [];
M(LinesToRemove,:) = [];

Wtt(:,LinesToRemove) = [];
Wtt(LinesToRemove,:) = [];

NG(:,LinesToRemove) = [];
NG(LinesToRemove,:) = [];

States = T(1,2:end);

States(LinesToRemove) = [];

eps  = 0.000001;

NTeams = size(M,1);

if pObs > 0
    
    SetGlobals(pObs,NTeams);
    
    [~,W] = GetSamplingMatrix(NTeams,pObs);
    
else
    
    [~,W,pObs] = GetSamplingMatrixFromPMatrixDB(M);
    
    M(isnan(M))     = 0;
    NG(isnan(NG))   = 0;
    Wtt(isnan(Wtt)) = 0;
    
    SetGlobals(pObs,size(M,1));
    
    P(isnan(P)) = 0;
    
end

if strcmp(RankType, 'MCMLE')
    [MT,R,~] = MCMLE(P,W,pObs,eps,NG,RMax);
    WVal = GetRankingFromRatios(MT);
else if strcmp(RankType, 'SMLE')        
    max_L = ceil(max(max(NG(NG > 0))));
    %w_min = 1/max_L/2;
    w_min = 0;
    [WVal,~] = SpectralMLE(P,W,size(P,1), max_L, pObs,w_min,1,1e-10);    
    end
end
    
TVec = 1 : 1 : length(WVal);
Rank = nan(1,length(WVal));

[~,IX]   = sort(WVal,'ascend');
Rank(IX) = TVec;

Ranking = [States ; num2cell(Rank)];

Ranking = Ranking';

end

