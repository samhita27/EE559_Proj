clear;
train_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/train_pp_nb.mat';


L = load(train_pp_file);
train = struct2table(L);
% train.patient_nbr = [];
train.encounter_id = [];
Y = train.readmitted;
train.readmitted = [];

test_pp_file = '/Users/samhitathakur/USC/Projects/EE559/dataset_diabetes/test_pp_nb.mat';


M = load(test_pp_file);
test = struct2table(M);
% test.patient_nbr = [];
test.encounter_id = [];
y_act = test.readmitted;
test.readmitted = [];

k = uint16(sqrt(height(train)));

cat_pred = [];

mdl = fitcknn(train,Y,'NumNeighbors',222,'CategoricalPredictors','all');

y_pred = predict(mdl,test);

classification_report(y_act,y_pred,1);







