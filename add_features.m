%% Clear
clear

%% Load the training data
tr_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_up.mat';

M = load(tr_file);

train = struct2table(M);
col_header = fieldnames(M);
N_tr = length(M.(col_header{1}));

%% Load the testing data
ts_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_up.mat';

L = load(ts_file);

test = struct2table(L);
N_ts = length(M.(col_header{1}));

%% Unique diagnostics
train(strcmp(train.diag_1,'?'),:) = [];
train(strcmp(train.diag_2,'?'),:) = [];
train(strcmp(train.diag_3,'?'),:) = [];

test(strcmp(test.diag_1,'?'),:) = [];
test(strcmp(test.diag_2,'?'),:) = [];
test(strcmp(test.diag_3,'?'),:) = [];

D = [train.diag_1;train.diag_1;train.diag_1;test.diag_1;test.diag_2;test.diag_3];
pattern = {'^250[.]\d'};%250.xx - Diabetes


mcs = cellfun(@(x)(mat2str(x)),D,'uniformoutput',false);

rep = {'250'};

D = regexprep(mcs,pattern,rep);


d = unique(mcs);

diag_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/diag.mat';

save(diag_file,'d');


