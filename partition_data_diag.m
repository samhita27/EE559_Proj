%% Clear
clear 

%% LOad MAT file
mat_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/diabetic_data_diag.mat';

M = load(mat_file);

T = struct2table(M);
col_header = fieldnames(M);
total_N = length(M.(col_header{1}));
clear M;

%% Segregate into Test and Training Sets

%Choose 50% data as test data and remaining as training
s = RandStream('mt19937ar','Seed',0);
I_test = randperm(s,total_N,total_N/2);
I_train = setdiff(1:total_N,I_test);

test = T(I_test,:);
train = T(I_train,:);
%% Choose unique patient ids - Remove this section if no deleteing rows
T_sort = sortrows(T,{'patient_nbr','encounter_id'},{'ascend','ascend'});

[pt_ids,ia,~] = unique(T_sort.patient_nbr);

T = T_sort(ia,:);

total_N = height(T);


%% Save Test Data and don't touch it for now.Save the training data to another file
test_data_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_diag.mat';
train_data_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_diag.mat';
test_data_set = table2struct(test,'ToScalar',true);
train_data_set = table2struct(train,'ToScalar',true);

save(test_data_file,'-struct','test_data_set');
save(train_data_file,'-struct','train_data_set');





