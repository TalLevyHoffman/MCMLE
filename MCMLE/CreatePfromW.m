function Pw = CreatePfromW(W,m,n)

%Input:
%%W  - The set of observed entries                    : [2 x |W|]
%%m  - Dimension 1 of matrix M that was sampled       : Scalar
%%n  - Dimension 1 of matrix M that was sampled       : Scalar
%Output:
%%Pw - A Binary matrix of obsereved coordibates       : [m x n]
%Computational Complexity:
%O(|W|)

Pw = zeros(m,n);

for i = 1 : 1 : size(W,2)
    Pw(W(1,i),W(2,i)) = 1;
    Pw(W(2,i),W(1,i)) = 1;
end

% for k = 1 : 1 : size(Pw,1)
%     Pw(k,k) = 1;
% end

end