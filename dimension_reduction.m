%% Normalize - zero mean unit variance

clear ;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp.mat';
train_pp_csv = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp.csv';

test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp.mat';
test_pp_csv = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp.csv';

M = load(test_pp_file);
test = struct2table(M);

L = load(train_pp_file);
train = struct2table(L);

% %% Select the columns to normalize
% cols_normalize = {'num_lab_procedures','num_medications','number_diagnoses',...
%    'number_emergency','number_inpatient','number_outpatient',...
%    'time_in_hospital','num_procedures','encounter_id','patient_nbr'};
% 
ch_train = train.Properties.VariableNames;
% col_tr = find(ismember(ch_train, cols_normalize));
% 
ch_test = test.Properties.VariableNames;
% col_ts = find(ismember(ch_test, cols_normalize));

%% Normalize all columns
label_col_tr = find(ismember(ch_train, 'readmitted'));
label_col_ts = find(ismember(ch_test, 'readmitted'));

Ytr = train.readmitted;
Yts = test.readmitted;

tol = 1e-10;

[n_train,mu,sigma] = zscore(double(table2array([train(:,1:label_col_tr-1) train(:,label_col_tr+1:end)])));
sigma(sigma<=tol) = 1; %// remove values close to zero
train = array2table(n_train);
n_test = bsxfun(@rdivide,bsxfun(@minus,double(table2array([test(:,1:label_col_ts-1) test(:,label_col_ts+1:end)])),mu),sigma);
test = array2table(n_test);


%% PCA

% train = [train(:,label_col_tr) train(:,1:label_col_tr-1) train(:,label_col_tr+1:end)];
Xtr = table2array(train);

% test = [test(:,label_col_ts) test(:,1:label_col_ts-1) test(:,label_col_ts+1:end)];
Xts = table2array(test);

[coeff,scores,latent] = pca(Xtr);

num_comps = 50;

Xtr = scores(:,1:num_comps);

Xts = Xts*coeff;

Xts = Xts(:,1:num_comps);

train = array2table([double(Ytr) Xtr]);
test = array2table([double(Yts) Xts]);

%% Write to files

writetable(test,test_pp_csv,'FileType','text');

writetable(train,train_pp_csv,'FileType','text');
