function [F1] = FactorMLE(M,P,F2,eps,dim,L)

if nargin < 6
    
    L = ones(size(M));
    
end

if size(L,dim) == 1
   
    L = L*ones(size(M));
    
end

n  = size(M,dim);
ML = max(L,[],dim);
ML = repmat(ML,(dim==1)*n+(dim==2),(dim==2)*n+(dim==1));   

W = L./ML;

W(isinf(L)) = 1;

for k = 1 : 1 : size(W,dim)
    W(k,k) = 1;
end
    
F2 = F2(:).';
Sq = (1/n)*sum(W./(1+M.*P),dim);
Sq = Sq(:).';

if dim == 1
   MF2 = (F2.'*ones(1,n)).*P;
else
   MF2 = (ones(n,1)*F2).*P; 
end

Mf = (1/n)*sum(W./(1+MF2),dim);

Mf = Mf(:).';

if dim == 1
    Check = (Sq < Mf);
else
    Check = (Sq > Mf);
end

F1 = nan(n,1);

if dim == 1
    P = P.';
    W = W.';
end

for q = 1 : 1 : n   
    
    if Check(q)
        F1(q) = MLE(F2,P(q,:),Sq(q),n,eps,W(q,:),dim);
    else
        F1(q) = 1;        
    end
    
end

end

function F1q = MLE(F2,Pq,Sq,n,eps,Wq,dim)

F1q = 1;

p = 2*(ceil((dim-1)/2)-0.5);

F2Pq = F2.*Pq;

TH = 1;
TL = 0;
TI = (TL+TH)*0.5;
F  = (1/n)*sum(Wq./(1+F2Pq*TI^p));

Count = 0;

%while abs(F - Sq) > eps
while (TH-TL) > 2*eps
    
    Count = Count + 1;
    
    if(F^(-p) > Sq^(-p))
        TH = TI;
    elseif (F^(-p) < Sq^(-p))
        TL = TI;
    else
        return;
    end
    
    TI = (TL+TH)*0.5;
    F  = (1/n)*sum(Wq./(1+F2Pq*TI^p));
    
end

F1q = TI^p;

end

function F1q = MLE2(F2,Pq,Sq,n,eps,dim)

p = 2*(ceil((dim-1)/2)-0.5);

F2Pq = F2.*Pq;

options = optimset('TolX',eps);

TI = fminbnd(@(x)CostFunction(x,n,p,F2Pq,Sq),0,1,options);

F1q = TI^p;

end

function Loss = CostFunction(x,n,p,F2Pq,Sq)

F    = (1/n)*sum(1./(1+F2Pq*x^p));
Loss = abs(F - Sq);

end