function [T,N] = preprocess_nb(T,N)
%% Pre-processing of features
missing_val = '?';

% Delete features with lots of missing data
% Delete Weight column as missing features = 97% and payer_code = 53%
T.weight = [];
T.payer_code = [];
T.medical_specialty = [];

%% Category features 
% race -  categorical
T(strcmp(T.race,'?'),:) = []; %Delete rows with missing values
%Update N
N = height(T);
[race,~] = category_to_num(T.race,missing_val);
T.race = [];
T = [T array2table(race)];

%gender - categorical
[gender,~] = category_to_num(T.gender,missing_val);
T.gender = [];
T = [T array2table(gender)];

%Age - Convert to a number (Age has an impact on health. Lower the age,
%better the health
[age,~] = category_to_num(T.age,missing_val);
T.age = [];
T = [T array2table(age)];

%admission_type_id - change to uint8
T.admission_type_id = uint8(T.admission_type_id);
[admission_type_mat,~] = category_to_num(T.admission_type_id,missing_val);
T.admission_type_id = [];
T = [T array2table(admission_type_mat)];

%discharge_disposition_id - change to uint8
T.discharge_disposition_id = uint8(T.discharge_disposition_id);
%Delete columns for which ddi = 11,13,14,19,20,21
% rowIndicator = [11,13,14,19,20,21];
% for k=1:length(rowIndicator)
%     toDelete = T.discharge_disposition_id==rowIndicator(1,k);
%     T(toDelete,:) = [];
% end
% %Update N
% N = height(T);
[discharge_disp_mat,~] = category_to_num(T.discharge_disposition_id,missing_val);
T.discharge_disposition_id = [];
T = [T array2table(discharge_disp_mat)];

%admission_source_id - change to uint8
T.admission_source_id = uint8(T.admission_source_id);
[admission_source_mat,~] = category_to_num(T.admission_source_id,missing_val);
T.admission_source_id = [];
T = [T array2table(admission_source_mat)];

%max_glu_serum - change to user defined category number
mgs_vs = {'None','Norm','>200','>300'};
mgs_cat = {'0','1','2','3'};
max_glu_serum = category_to_num_pd(T.max_glu_serum,missing_val,mgs_vs,mgs_cat);
T.max_glu_serum = [];
T = [T array2table(max_glu_serum)];

%A1Cresult - - change to user defined category number
a1c_vs = {'None','Norm','>7','>8'};
a1c_cat = {'0','1','2','3'};
A1Cresult = category_to_num_pd(T.A1Cresult,missing_val,a1c_vs,a1c_cat);
T.A1Cresult = [];
T = [T array2table(A1Cresult)];

%change - - change to user defined category number
ch_vs = {'No','Ch'};
ch_cat = {'0','1'};
change = category_to_num_pd(T.change,missing_val,ch_vs,ch_cat);
T.change = [];
T = [T array2table(change)];

%diabetesMed - change to user defined category number
dm_vs = {'No','Yes'};
dm_cat = {'0','1'};
diabetesMed = category_to_num_pd(T.diabetesMed,missing_val,dm_vs,dm_cat);
T.diabetesMed = [];
T = [T array2table(diabetesMed)];

%readmitted - Convert to a number (final class value)
[readmitted,~] = category_to_num(T.readmitted,missing_val);
T.readmitted = [];
T = [T array2table(readmitted)];

%Category definitions for medications
meds_vs = {'No','Up','Steady','Down'};
meds_cat = {'0','1','2','3'};

%medecines - change to user defined category number
medicines = {'acarbose','acetohexamide','chlorpropamide','citoglipton','examide','glimepiride',....
    'glimepiridepioglitazone','glipizide','glipizidemetformin','glyburide','glyburidemetformin',....
    'insulin','metformin','metforminpioglitazone','metforminrosiglitazone','miglitol',.....
    'nateglinide','pioglitazone','repaglinide','rosiglitazone','tolazamide','tolbutamide',.....
    'troglitazone'};
med_mat = zeros(N,length(medicines));

for i=1:length(medicines)
    med_mat(:,i) = category_to_num_pd(T.(medicines{i}),missing_val,meds_vs,meds_cat);
    T.(medicines{i}) = [];
end
med_mat = uint8(med_mat);
T = [T array2table(med_mat)];

%diag_1, diag_2, diag_3
% Delete Rows with missing diag_1, diag_2, diag_3 values
T(strcmp(T.diag_1,'?'),:) = [];
T(strcmp(T.diag_2,'?'),:) = [];
T(strcmp(T.diag_3,'?'),:) = [];
%Update N
N = height(T);
%Convert diagnosis values to a numerical category
f = @diagnosis_category;
diag_1 = cellfun(@(x) diagnosis_category(x),T.diag_1);
diag_2 = cellfun(@(x) diagnosis_category(x),T.diag_2);
diag_3 = cellfun(@(x) diagnosis_category(x),T.diag_3);
diag1_mat = category_to_num(diag_1,missing_val);
diag2_mat = category_to_num(diag_2,missing_val);
diag3_mat = category_to_num(diag_3,missing_val);
T.diag_1 = [];
T.diag_2 = [];
T.diag_3 = [];

T = [T array2table(diag1_mat) array2table(diag2_mat) array2table(diag3_mat)];

% T.encounter_id = [];
% T.patient_nbr = [];

col_headers = T.Properties.VariableNames;
label_col = find(ismember(col_headers, 'readmitted'));
T = [T(:,label_col) T(:,1:label_col-1) T(:,label_col+1:end)];


end