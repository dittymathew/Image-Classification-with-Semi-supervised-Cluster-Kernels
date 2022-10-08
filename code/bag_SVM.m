function [accBAG,conf] = bag_SVM(train_x,train_y,test_x,test_y, N, k,gamma, mode)

addedPts = 100; %% Add points for kmeans if training points are not enough

Ktrain = kernelmatrix(train_x,gamma);


c = randperm(length(test_y))';
Kbag = zeros(length(train_y)+addedPts);
for n=1:N
        
        [IDX,C] = kmeans([train_x; test_x(c(1:addedPts),:)],k,'Distance','cosine');
        
        for i=1:length(train_y)+addedPts
            
            for j=1:length(train_y)+addedPts
                if IDX(i) == IDX(j)
                    Kbag(i,j) = Kbag(i,j) + 1;
                end
            end;
        end;
        
        IDX_tot(:,n) = IDX;
        clear IDX
        C_tot(:,:,n) = C;
        clear C
end;
% Normalize the bag kernel:
Kbag = Kbag/(N);

%Kbag is the train bagged kernel
Kbag = Kbag(1:size(train_x,1),1:size(train_x,1));
%IDX_tot is the matrix containing cluster centers for the N bags.
IDX_tot = IDX_tot(1:size(train_x,1),:);
disp('Bag kernel constructed!');
figure;
subplot(311),imagesc(Ktrain),colorbar,title('Train kernel - Standard SVM')
subplot(312),imagesc(Kbag),colorbar,title('Train kernel - K-means')

Ktrain =[(1:size(Ktrain,1))',Ktrain];
% Construct the train kernel
if mode == ['p']
    Ktrain = Ktrain(:,2:end).*Kbag;
else
    Ktrain = 0.5*Ktrain(:,2:end)+0.5*Kbag;
end

subplot(313),imagesc(Ktrain);
colorbar;
title('Train kernel - BagSVM');


%%

j=0;
Ktrain =[(1:size(Ktrain,1))',Ktrain];

for c = [0.01,0.1,1, 10,100]
    j=j+1;
    model  = svmtrain(train_y,Ktrain,['-t 4 -v 3 -c ' num2str(c)]);
    res(j,:) = [c model];
end;

% Select the best model
[kk j] = max(res(:,2));
C = res(j,1);

%%
Ktest  = kernelmatrix(test_x,gamma); %SVM kernel matrix
figure
subplot(311),imagesc(Ktest),colorbar,title('Test Kernel - Standard SVM')

%Construct kernel for the unlabeled samples
KbagUL = zeros(size(test_x,1),size(test_x,1));
    
for n=1:N
    ID_UL = closerCluster(test_x,C_tot(:,:,n),k);
    for p=1:size(ID_UL,1)
            for q=1:size(IDX_tot,1)
                if IDX_tot(q,n) == ID_UL(p,1)
                    KbagUL(q,p) = KbagUL(q,p) + 1;
                end
            end;
    end;
 end
    
    %KbagUL is the test Kernel
    KbagUL = KbagUL/N;
    
    subplot(312),imagesc(KbagUL),colorbar,title('Test kernel - K-means');
    
    if mode == ['p']
    Ktest      = Ktest.*KbagUL;
    else
    Ktest      = 0.5*Ktest+0.5*KbagUL;
end


subplot(313),imagesc(Ktest),colorbar,title('Test Kernel - BAG SVM');
Ktest =[(1:size(Ktest',1))',Ktest'];

model  = svmtrain(train_y,Ktrain,['-t 4 -c ' num2str(C)]);
[Ypred,accBAG,d_val] = svmpredict(test_y,Ktest,model);
ACCURACY_FULL =  assessment(test_y,Ypred,'class');
conf=ACCURACY_FULL.ConfusionMatrix;
    

end
