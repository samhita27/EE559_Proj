%% Load Data

clear;

train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_nb.mat';
test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_nb.mat';


M = load(train_pp_file);
train = struct2table(M);

L = load(test_pp_file);
test = struct2table(L);

%% Feature Selection

ytr = train.readmitted;
train.readmitted = [];
col_h = train.Properties.VariableNames;
Xtr = zeros(size(train));
for i=1:length(col_h)
    Xtr(:,i) = double(train.(col_h{i}));
end

tenfoldCVP = cvpartition(ytr,'kfold',3);

classf = @(X_train,y_train,X_test,y_test) ...
             sum(~strcmp(y_test,predict(fitctree(X_train,y_train),X_test)));

opts = statset('display','iter');         
fsLocal = sequentialfs(classf,Xtr,ytr,'cv',tenfoldCVP,'options',opts,'direction','backward','nfeatures',10);

% %% Test selected columns on the test data
% yts = test.readmitted;
% test.readmitted = [];
% col_s = test.Properties.VariableNames;
% Xts = zeros(size(test));
% for i=1:length(col_s)
%     Xts(:,i) = double(test.(col_s{i}));
% end




