function R = GetRankingFromRatios(M)

R = M(1,:);
R = 1./R;
R = R/min(R);

end