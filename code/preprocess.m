clear;clc;close all;
addpath('./code_svm')

set_name = '101';  % dataset_name, {'15', '21', '25',  '101'}

data_dir = './data/';    


%% loading data


fet_x  = [];

data_name = strcat( data_dir, set_name, '_', 'gist', '.mat'); 
load(data_name);
    
             
fet_x  =  cat(2, fet_x, data.fet);    
   

%     
% data_name = strcat( data_dir, set_name, '_', 'phog', '.mat'); 
% load(data_name);
% fet_x  =  cat(2, fet_x, data.fet);   
%    
% 
% data_name = strcat( data_dir, set_name, '_', 'lbp', '.mat'); 
% load(data_name);
% fet_x  =  cat(2, fet_x, data.fet);

fet_y   =data.lab;


train_num = 100;                          % the number of labeled training data per class 
test_num = 200; 
%unseen_num=100;
train_index = [];                       % index of labeled training data
test_index = [];                        % index of unlabeled training (test) data
%unseen_index=[];

%%Randomly selecting data from each class
for c= [1,2,4,6] % 101 -[1,2,4,6] 15- [2,3,5,6]
    disp(c);
    index_c = find(data.lab==c); 
    randIndex = randperm(length(index_c));
    train_index = cat(1, train_index, index_c(randIndex(1:train_num))); 
    test_index = cat(1, test_index, index_c(randIndex(train_num+1:train_num+test_num)));
   % unseen_index = cat(1, unseen_index, index_c(randIndex(train_num+test_num+1:train_num+test_num+unseen_num)));
end
train_x = fet_x(train_index,:);
train_y = fet_y(train_index,:);
test_x  = fet_x(test_index,:);
test_y  = fet_y(test_index,:);
%unseen_x  = fet_x(unseen_index,:);
%unseen_y  = fet_y(unseen_index,:);


% train_x =Xnorm(train_x,-10,10);
% test_x =Xnorm(test_x,-10,10);
[accSVM,gamma,svm_conf] =rbf_SVM(train_x,train_y,test_x,test_y);
N=100;
k=40;
% mode ='s';  % 's' - Sum , 'p' - Product
BAGacc=[];
best_acc=0;

for k=[5, 10,20,70,100]
[accBAG,conf] = bag_SVM(train_x,train_y,test_x,test_y, N, k,gamma, 's');
BAGacc=[BAGacc,accBAG(1,1)];
if accBAG(1,1)>best_acc
    best_acc=accBAG(1,1);
    best_conf=conf;
end
end;
disp(accSVM);
 disp(svm_conf);
 disp(BAGacc);
 disp(best_conf);
 figure;
 plot([10,50,60,70,100]',BAGacc','linewidth',2);
 xlabel('K','fontsize',12);
 ylabel('Accuracy','fontsize',12);
