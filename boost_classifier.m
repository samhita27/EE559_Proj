%% Load data
clear;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_up_norm.mat';


L = load(train_pp_file);
train = struct2table(L);
% train.patient_nbr = [];
% train.encounter_id = [];

test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_up_norm.mat';


M = load(test_pp_file);
test = struct2table(M);
% test.patient_nbr = [];
% test.encounter_id = [];

%% Boosting
t = templateDiscriminant('DiscrimType','diagLinear');

ensmbl = fitensemble(train,'readmitted','AdaBoostM2',100,t);

y_actual = test.readmitted;

test.readmitted = [];

y_pred = predict(ensmbl,test);

classification_report(y_actual,y_pred,0);
