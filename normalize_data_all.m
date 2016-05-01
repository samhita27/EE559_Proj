%% Normalize - zero mean unit variance

clear ;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_up_bl.mat';
train_pp_norm = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_up_bl_norm.mat';


test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_up_bl.mat';
test_pp_norm = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_up_bl_norm.mat';


M = load(test_pp_file);
test = struct2table(M);

L = load(train_pp_file);
train = struct2table(L);

%% Select the columns to normalize

% train.patient_nbr = [];
% train.encounter_id = [];

% test.patient_nbr = [];
% test.encounter_id = [];

% cols_normalize = {'num_lab_procedures','num_medications','number_diagnoses',...
%    'number_emergency','number_inpatient','number_outpatient',...
%    'time_in_hospital','num_procedures','encounter_id','patient_nbr'};
% 
cols = train.Properties.VariableNames;
% col_tr = find(ismember(ch_train, cols_normalize));
% 
% col_ts = find(ismember(ch_test, cols_normalize));

cols(strcmp(cols,'readmitted')) = [];


%% Normalize all columns

tol = 1e-10;

readmitted_tr = train.readmitted;
readmitted_ts = test.readmitted;

train.readmitted = [];
test.readmitted = [];

[n_train,mu,sigma] = zscore(double(table2array(train)));
train = array2table(n_train);
sigma(sigma<=tol) = 1; %// remove values close to zero
n_test = bsxfun(@rdivide,bsxfun(@minus,double(table2array(test)),mu),sigma);
test = array2table(n_test);

train = [array2table(readmitted_tr) train];
test = [array2table(readmitted_ts) test];

cols(2:end+1)=cols;
cols{1} = 'readmitted';

train.Properties.VariableNames = cols;
test.Properties.VariableNames = cols;

%% Write to file

test_pp_ds = table2struct(test,'ToScalar',true);

save(test_pp_norm,'-struct','test_pp_ds');

train_pp_ds = table2struct(train,'ToScalar',true);

save(train_pp_norm,'-struct','train_pp_ds');

