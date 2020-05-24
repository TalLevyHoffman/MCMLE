function [Pw,W] = GetSamplingMatrix(NTeams,pObs)

WF = nan(2,NTeams*(NTeams+1)/2);
Ie = 0;

for k = 1 : 1 : NTeams

    Is = Ie + 1;
    Ie = Is + (NTeams-k);
    WF(1,Is:Ie) = k*ones(1,NTeams-k+1);
    WF(2,Is:Ie) = k:1:NTeams;

end

Select = rand(1,size(WF,2));
W      = WF(:,Select <= pObs);

Pw = CreatePfromW(W,NTeams,NTeams);

end