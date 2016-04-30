%% Clear
clear

%% Load the testing data
mat_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_up.mat';

M = load(mat_file);

test = struct2table(M);
col_header = fieldnames(M);
N = length(M.(col_header{1}));

%% Pre-processing of features
[test,N] = preprocess(test,N);

%% Save the pre-processed testing data as .mat and .csv files
test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_up.mat';

test_pp_ds = table2struct(test,'ToScalar',true);

save(test_pp_file,'-struct','test_pp_ds');






