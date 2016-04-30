%% Normalize - zero mean unit variance

clear ;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_up.mat';
train_pp_norm = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_up_norm1.mat';


test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_up.mat';
test_pp_norm = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_up_norm1.mat';


M = load(test_pp_file);
test = struct2table(M);

L = load(train_pp_file);
train = struct2table(L);

%% Select the columns to normalize
cols_normalize = {'num_lab_procedures','num_medications','number_diagnoses',...
   'number_emergency','number_inpatient','number_outpatient',...
   'time_in_hospital','num_procedures','encounter_id','patient_nbr'};

ch_train = train.Properties.VariableNames;
col_tr = find(ismember(ch_train, cols_normalize));

ch_test = test.Properties.VariableNames;
col_ts = find(ismember(ch_test, cols_normalize));

%% Normalize selected columns
[n_train,mu,sigma] = zscore(table2array(train(:,col_tr)));
train(:,col_tr) = array2table(n_train);
n_test = bsxfun(@rdivide,bsxfun(@minus,table2array(test(:,col_ts)),mu),sigma);
test(:,col_ts) = array2table(n_test);

label_col_tr = find(ismember(ch_train, 'readmitted'));
train = [train(:,label_col_tr) train(:,1:label_col_tr-1) train(:,label_col_tr+1:end)];

label_col_ts = find(ismember(ch_test, 'readmitted'));
test = [test(:,label_col_ts) test(:,1:label_col_ts-1) test(:,label_col_ts+1:end)];

%% Write to file

test_pp_ds = table2struct(test,'ToScalar',true);

save(test_pp_norm,'-struct','test_pp_ds');

train_pp_ds = table2struct(train,'ToScalar',true);

save(train_pp_norm,'-struct','train_pp_ds');

