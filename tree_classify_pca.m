%% Load data
clear;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_up_pca.mat';


L = load(train_pp_file);
train = struct2table(L);
% train.patient_nbr = [];
% train.encounter_id = [];

test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_up_pca.mat';


M = load(test_pp_file);
test = struct2table(M);
% test.patient_nbr = [];
% test.encounter_id = [];

%% Specify options

cols = train.Properties.VariableNames;



%% Comment out the section for CV
k = 10:1000:10010

err = size(1:numel(k));

for i = 1:numel(k)
    tree = fitctree(train,'readmitted','CrossVal','on','KFold',5,'MaxNumSplits',k(i));
    err(1,i) = kfoldLoss(tree);
end

figure
stem(k,err);



%% Training and Testing

%Use cross-validated parameter in the model
[m,idx] = min(err);
tree = fitctree(train,'readmitted','MaxNumSplits',k(idx));

y_actual = test.readmitted;

test.readmitted = [];

y_pred = predict(tree,test);

classification_report(y_actual,y_pred,0);

