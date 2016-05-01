clear;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_up_norm.mat';


L = load(train_pp_file);
train = struct2table(L);
% train.patient_nbr = [];
% train.encounter_id = [];
y = train.readmitted;
train.readmitted = [];

test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_up_norm.mat';


M = load(test_pp_file);
test = struct2table(M);
% test.patient_nbr = [];
% test.encounter_id = [];
y_actual = test.readmitted;
test.readmitted = [];

if isinteger(table2array(train))
    col_h = train.Properties.VariableNames;
    X_tr = zeros(size(train));
    X_ts = zeros(size(test));
    for i=1:length(col_h)
        X_tr(:,i) = double(train.(col_h{i}));
        X_ts(:,i) = double(test.(col_h{i}));
    end
else
    X_tr = table2array(train);
    X_ts = table2array(test);
end



lambda = logspace(-7,-9,15);
err = size(1:numel(lambda));

S = struct('ClassNames',[1 2 3],'ClassificationCosts',[0 30 60;1 0 1;1 1 0]);


for i=1:length(lambda)
    t = templateLinear('Regularization','lasso','Lambda',lambda(i));
    mdl = fitcecoc(X_tr,y,'CrossVal','on','KFold',5,'Learners',t);
    err(1,i) = kfoldLoss(mdl);
end

tr_acc = (1-mean(err))*100;

figure
stem(1:numel(lambda),err);
set(gca,'XTickLabel',lambda); % Change x-axis ticks labels to desired values.

%Use cross-validated parameter in the model
[m,idx] = min(err);
t = templateLinear('Learner','logistic','Regularization','lasso','Lambda',lambda(idx));
mdl = fitcecoc(X_tr,y,'Learners',t);

%Apply on testing
y_pred = predict(mdl,X_ts);

classification_report(y_actual,y_pred,0);
