%% Load Data

clear;

addpath '/Users/samhitathakur/USC/Projects/EE559/mi/';

train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_norm.mat';
test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_norm.mat';


M = load(train_pp_file);
train = struct2table(M);

L = load(test_pp_file);
test = struct2table(L);

%% Feature Selection

y = double(train.readmitted);
train.readmitted = [];
col_h = train.Properties.VariableNames;
X = zeros(size(train));

for i=1:length(col_h)
    X(:,i) = double(train.(col_h{i}));
end

cor = zeros(1,length(col_h));
m = zeros(1,length(col_h));

for i=1:length(col_h)
R = corrcoef(X(:,i),y);
cor(1,i) = R(1,2)*R(1,2);
m(1,i) = mutualinfo(X(:,i),y);
end

f = vertcat(cor,m);

tol = 1e-3;

idx = find(f(1,:)<tol & f(2,:)<tol);

X_sel = X(:,idx);

t = templateLinear('Regularization','lasso','Lambda',0.00001);

mdl = fitcecoc(X_sel,y,'Learners',t);

yts = double(test.readmitted);
test.readmitted = [];
col_s = test.Properties.VariableNames;
Xts = zeros(size(test));
for i=1:length(col_s)
    Xts(:,i) = double(test.(col_s{i}));
end

y_pred = predict(mdl,Xts(:,idx));

classification_report(yts,y_pred,1);


