function U0 = InitializeU(M,Pw0,p,k)

%Input:
%%M    - The input matrix of rank k                          : [m x n]
%%Pwtt - The observed coordinates of M at stage 0            : [m x n]
%%p    - The probability of observing a coordinate uniformly : Scalar
%%k    - The rank of M                                       : Scalar
%Output:
%%UC - The top left k singular vectors of M                  : [m x k]
%Computational Complexity:
%O(m * k * k)

[U0,~,~] = svds((1/p)*(M.*Pw0),k,'L');

end