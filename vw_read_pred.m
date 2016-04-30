clear;
vw_pred_file = '/Users/samhitathakur/USC/Projects/EE559/Project_EE559_Code/svm.data';
test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp.mat';

s = load(test_pp_file);

T = struct2table(s);

fileID = fopen(vw_pred_file,'r');
y_pred = fscanf(fileID,'%f');
fclose(fileID);

col_headers = T.Properties.VariableNames;
label_col = find(ismember(col_headers, 'readmitted'));
y_act = double(table2array(T(:,label_col)));


classification_report(y_act,y_pred,1);


