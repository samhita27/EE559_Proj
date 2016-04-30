clear;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_up_norm1.mat';


L = load(train_pp_file);
train = struct2table(L);
% train.patient_nbr = [];
% train.encounter_id = [];
y = train.readmitted;
train.readmitted = [];

test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_up_norm1.mat';


M = load(test_pp_file);
test = struct2table(M);
% test.patient_nbr = [];
% test.encounter_id = [];
y_actual = test.readmitted;
test.readmitted = [];

X_tr = table2array(train);
X_ts = table2array(test);

lambda = logspace(0,-3,15);
err = size(1:numel(lambda));


for i=1:length(lambda)
    t = templateLinear('Regularization','ridge','Lambda',lambda(i));
    mdl = fitcecoc(X_tr,y,'CrossVal','on','KFold',5,'Learners',t);
    err(1,i) = kfoldLoss(mdl);
end

% figure
% stem(1:numel(lambda),err);
% set(gca,'XTickLabel',lambda); % Change x-axis ticks labels to desired values.

%Use cross-validated parameter in the model
[m,idx] = min(err);
t = templateLinear('Regularization','ridge','Lambda',lambda(idx));
mdl = fitcecoc(X_tr,y,'Learners',t);

%Apply on testing
y_pred = predict(mdl,X_ts);

classification_report(y_actual,y_pred,0);


