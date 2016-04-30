%% Clear
clear

%% Load the training data
mat_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train.mat';

M = load(mat_file);

train = struct2table(M);
col_header = fieldnames(M);
N = length(M.(col_header{1}));

%% Preprocess data
[train,N] = preprocess_nb(train,N);


%% Save the pre-processed training data as .mat and .csv files
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_nb.mat';

train_pp_ds = table2struct(train,'ToScalar',true);

save(train_pp_file,'-struct','train_pp_ds');


