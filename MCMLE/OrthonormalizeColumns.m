function UC = OrthonormalizeColumns(U0)

%Input:
%%U0 - The calculated factor matrix U at stage 0 after clipping : [m x k]
%Output:
%%UC - The factor matrix U0 after columns orthonormalization    : [m x k]
%Computational Complexity:
%O(m * k * k)

m  = size(U0,1);
k  = size(U0,2);
UC = zeros(m,k);

UC(:,1) = U0(:,1) / sqrt( U0(:,1)'*U0(:,1) );

for i = 2 : 1 : k
    
    UC(:,i) = U0(:,i);
    
    for j = 1 : 1 : i-1
       
       UC(:,i) = UC(:,i) - ( UC(:,i)'*UC(:,j) )/( UC(:,j)'*UC(:,j) )*UC(:,j);
        
    end

    UC(:,i) = UC(:,i) / sqrt( UC(:,i)'*UC(:,i) );
    
end

end