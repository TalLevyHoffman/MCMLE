function W = CreateWfromPw(Pw)

%Input:
%%Pw - A Binary matrix of obsereved coordibates : [m x n]
%Output:
%%W  - The set of observed entries              : [2 x |W|]
%Computational Complexity:
%O(m*n)

m = size(Pw,1);
I = find(Pw == 1);

Y = ceil(I/m);
X = I - (Y-1)*m;

W = [X' ; Y'];

end