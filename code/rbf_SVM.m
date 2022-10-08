function [accSVM,gamma,conf] = rbf_SVM(train_x,train_y,test_x,test_y,unseen_x,unseen_y)

j=0;
res=[];
res=double(res);
for gamma =0.009
    Ktrain = kernelmatrix(train_x,gamma);
  
    disp(gamma);
    for c =[0.001,0.01,0.1,1,10,100,1000]
       
        j=j+1;
         Ktrain =[(1:size(Ktrain,1))',Ktrain];
        model  = svmtrain(train_y,Ktrain,['-t 4 -v 3 -c ' num2str(c) ]);
%          model  = svmtrain(train_y,train_x,['-t 0 -v 3 -c ' num2str(c) ' -g ' num2str(gamma)]);
        res(j,:) = [gamma c model*100];
        disp([gamma c model])
     end;
end;
% 
% % Select the best model

[kk j] = max(res(:,3));
gamma = res(j,1);
C = res(j,2);
disp(res);
% % Train with the best model
Ktrain = kernelmatrix(train_x,gamma);
% figure;
% imshow(Ktrain);
% colorbar,title('Train Kernel - Standard SVM(RBF)')
Ktest  = kernelmatrix(test_x,gamma)';
% figure;
% imshow(Ktest);
% colorbar,title('Test Kernel - Standard SVM(RBF)')
Ktest =[(1:size(test_y,1))',Ktest];
Ktrain =[(1:size(Ktrain,1))',Ktrain];
model  = svmtrain(train_y,Ktrain,['-t 4 -c ' num2str(C)  ]);

% 
% % Predict in test
% 
% 
 [Ypred,accSVM,dval] = svmpredict(test_y,Ktest,model);
disp(sprintf('Best Gamma =%f C= %f',gamma,C));
% disp (res);
ACCURACY_FULL =  assessment(test_y,Ypred,'class');
conf=ACCURACY_FULL.ConfusionMatrix;
disp(ACCURACY_FULL.ConfusionMatrix);
end
