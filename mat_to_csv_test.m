%% Load the data
clear

test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp.mat';
test_pp_csv = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp.csv';

s = load(test_pp_file);

T = struct2table(s);

% label_col = 157;
% 
% T = [T(:,label_col) T(:,1:label_col-1) T(:,label_col+1:end)];

writetable(T,test_pp_csv,'FileType','text');



