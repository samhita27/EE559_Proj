%% Load data
clear;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_up.mat';


L = load(train_pp_file);
train = struct2table(L);
train.patient_nbr = [];
train.encounter_id = [];

test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_up.mat';


M = load(test_pp_file);
test = struct2table(M);
test.patient_nbr = [];
test.encounter_id = [];

%% Specify options

cols = train.Properties.VariableNames;

% features = {'A1Cresult','admission_source_mat','age','diag1_mat','discharge_disp_mat',...
%     'gender','race','time_in_hospital'};

features = {'age','discharge_disp_mat',...
    'diag1_mat','gender','time_in_hospital','race'};


% cat_preds = {'A1Cresult','admission_source_mat','admission_type_mat','change',...
%     'diabetesMed','diag1_mat','diag2_mat','diag3_mat','discharge_disp_mat',...
%     'gender','max_glu_serum','med_mat1','med_mat10','med_mat11','med_mat12',...
%     'med_mat13','med_mat14','med_mat15','med_mat16','med_mat17','med_mat18',...
%     'med_mat19','med_mat2','med_mat20','med_mat21','med_mat22','med_mat23',...
%     'med_mat3','med_mat4','med_mat5','med_mat6','med_mat7','med_mat8','med_mat9',...
%     'race'};


%% Comment out the section for CV
k = 100:5:150

err = size(1:numel(k));

for i = 1:numel(k)
    tree = fitctree(train,'readmitted','CrossVal','on','KFold',5,'MaxNumSplits',k(i));
    err(1,i) = kfoldLoss(tree);
end

figure
stem(k,err);



%% Training and Testing

%Use cross-validated parameter in the model
[m,idx] = min(err);
tree = fitctree(train,'readmitted','MaxNumSplits',k(idx));

y_actual = test.readmitted;

test.readmitted = [];

y_pred = predict(tree,test);

classification_report(y_actual,y_pred,0);

