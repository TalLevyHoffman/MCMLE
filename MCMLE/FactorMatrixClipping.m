function U0 = FactorMatrixClipping(U0,mu,m,k)

%Input:
%%%U0 - The calculated factor matrix U at stage 0          : [m x k]
%%%mu - The incoherence index                              : Scalar
%%%m  - The long dimension of U0                           : Scalar
%%%m  - The short dimension of U0                          : Scalar
%Output:
%%%U0 - The factor matrix U0 after removing entries grater : [m x k]
%%%     than mu/sqrt(m)                                    
%Computational Complexity:
%O(m * k)

U0(abs(U0) > 2*mu * sqrt(k) / sqrt(m)) = 0; 

end