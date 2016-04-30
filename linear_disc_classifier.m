%% Load data
clear;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_norm.mat';


L = load(train_pp_file);
train = struct2table(L);
% train.patient_nbr = [];
% train.encounter_id = [];

test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_norm.mat';


M = load(test_pp_file);
test = struct2table(M);
% test.patient_nbr = [];
% test.encounter_id = [];

%% Training and Testing
Y = train.readmitted;
train.readmitted = [];
X = double(table2array(train));

obj = fitcdiscr(X,Y,'DiscrimType','diagLinear');


y_actual = test.readmitted;
test.readmitted = [];
X_test = double(table2array(test));

y_pred = predict(obj,X_test);

classification_report(y_actual,y_pred,0);


