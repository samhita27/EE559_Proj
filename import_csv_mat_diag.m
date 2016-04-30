%% Clear
clear 


%% Import the data from csv file to MATLAB vectors
data_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/diabetic_data.csv';

[encounter_id,patient_nbr,race,gender,age,weight,admission_type_id,discharge_disposition_id,admission_source_id,time_in_hospital,payer_code,medical_specialty,num_lab_procedures,num_procedures,num_medications,number_outpatient,number_emergency,number_inpatient,diag_1,diag_2,diag_3,number_diagnoses,max_glu_serum,A1Cresult,metformin,repaglinide,nateglinide,chlorpropamide,glimepiride,acetohexamide,glipizide,glyburide,tolbutamide,pioglitazone,rosiglitazone,acarbose,miglitol,troglitazone,tolazamide,examide,citoglipton,insulin,glyburidemetformin,glipizidemetformin,glimepiridepioglitazone,metforminrosiglitazone,metforminpioglitazone,change,diabetesMed,readmitted] = orig_importfile(data_file,2, 101767);

%% Save the imported data to .mat file
mat_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/diabetic_data_diag.mat';

save(mat_file,'encounter_id','patient_nbr','race','gender','age','weight','admission_type_id','discharge_disposition_id','admission_source_id','time_in_hospital','payer_code','medical_specialty','num_lab_procedures','num_procedures','num_medications','number_outpatient','number_emergency','number_inpatient','diag_1','diag_2','diag_3','number_diagnoses','max_glu_serum','A1Cresult','metformin','repaglinide','nateglinide','chlorpropamide','glimepiride','acetohexamide','glipizide','glyburide','tolbutamide','pioglitazone','rosiglitazone','acarbose','miglitol','troglitazone','tolazamide','examide','citoglipton','insulin','glyburidemetformin','glipizidemetformin','glimepiridepioglitazone','metforminrosiglitazone','metforminpioglitazone','change','diabetesMed','readmitted');



