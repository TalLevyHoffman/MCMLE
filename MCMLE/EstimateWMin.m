function WMinE = EstimateWMin(pAverage)

WMinT = 0 : 0.001 : 1;
PM    = PM_0(WMinT);

I = find(abs(PM-pAverage) == nanmin(abs(PM-pAverage)) , 1 , 'first');

WMinE = WMinT(I);

end