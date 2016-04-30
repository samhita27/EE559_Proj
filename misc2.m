%% Load data
clear;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp.mat';


L = load(train_pp_file);
train = struct2table(L);
train.patient_nbr = [];
train.encounter_id = [];

test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp.mat';


M = load(test_pp_file);
test = struct2table(M);
test.patient_nbr = [];
test.encounter_id = [];

a = sum(test.readmitted == 1);
