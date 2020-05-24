function [MT,R,Iter] = MCMLE(pMAT,W,p,eps,L,RMax,Qi)

k = 1;

global Q

if isempty(Q)
 Q = 1.4;
end

if nargin < 8
 Qi = Q;
end

m   = size(pMAT,1);
n   = size(pMAT,2);

Pw = CreatePfromW(W,m,n);

for i = 1 : 1 : size(Pw,1)
    Pw(i,i) = 1;
end

if RMax < 0

    TMat  = pMAT; TMat(~logical(Pw)) = nan;
    for i = 1 : 1 : n
        TMat(i,i) = nan;
    end
    MVec  = nanmean(TMat,2);
    IMin  = find(MVec == min(MVec) , 1 , 'first');
    WMinE = EstimateWMin(nanmean(TMat(IMin,:)));
    RMax  = 1/WMinE;    
    RMax  = max(RMax,1.8);
    
end

DelMin  = eps/20;

M = (1./pMAT - 1).';

M(M>Qi*RMax) = Qi*RMax;

MaxIter = round(4*log(1/(2*eps))/log(4));

U0  = InitializeU(M,Pw,p,k);

U0  = FactorMatrixClipping(U0,2*RMax*sqrt(n),n,k);

if sum(sign(U0)) < 0
   U0 = -U0; 
end

%Utt = U0;

Utt = OrthonormalizeColumns(U0);  

Utt(Utt < 1/(Qi*RMax)) = 1/(Qi*RMax);

Iter = 0;

Mp = zeros(size(M));
Mc = Utt*(1./Utt).';

while( norm(Mp-Mc,'fro') > DelMin  && (Iter < MaxIter) )
    
    Mp = Mc;
    
    [Vtt] = FactorMLE(M,Pw,Utt,eps*n,1,L);
    [Utt] = FactorMLE(M,Pw,Vtt,eps*n,2,L);     
    
    Utt(Utt < 1/(Qi*RMax)) = 1/(Qi*RMax);
    Vtt(Vtt > (Qi*RMax))   = (Qi*RMax);
    
    if ~isinf(min(min(L)))
        Rtt = (Utt + 1./Vtt)*0.5;    
        Rtt = Rtt/max(Rtt);

        Rtt(Rtt < 1/(Qi*RMax)) = 1/(Qi*RMax);
        Rtt(Rtt > Qi*RMax)     = Qi*RMax;

        Utt = Rtt;
        Vtt = 1./Rtt;
    end
        
    Iter = Iter + 1;
    
    Mc = Utt*Vtt.';
        
end

if sum(Utt > 1) > sum(Vtt > 1)
   %Ttt = Utt; 
   Utt = Vtt; 
   %Vtt = Ttt; 
end

R  = Utt;
R  = R / max(R);

R(R < 1/(Qi*RMax)) = 1/(Qi*RMax);     
    
MT = R * (1./R)';

end