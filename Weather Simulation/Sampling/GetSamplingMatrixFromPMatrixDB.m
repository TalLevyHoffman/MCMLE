function [Pw,W,pObs] = GetSamplingMatrixFromPMatrixDB(pMat)

NTeams = size(pMat,1);

Pw = ones(size(pMat));
Pw(isnan(pMat)) = 0;

W = CreateWfromPw(Pw);

pObs = size(W,2) / (NTeams*(NTeams+1)/2);

end