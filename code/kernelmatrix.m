function K = kernelmatrix(X,gamma);
 

A = sum(X .* X, 2);
B = -2 *( X * X');
K = bsxfun(@plus, A, B);
K = bsxfun(@plus, K, A');
K = K *gamma;
K = exp(-K);

% K=zeros(size(X,1),size(X,1));
% 
% for i=1:size(X,1)
%  for j=1:size(X,1)
%         K(i,j)= sum(min(X(i,:),X(j,:)));
%  end
% end

end