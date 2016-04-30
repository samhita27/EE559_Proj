function cat_val = diagnosis_category(str)

num_pattern = 20;
val = 0;
cat_val = 0;
pattern = cell(num_pattern,1);

pattern{1} = '(^0\d\d$|^1[0-3]\d$|^\d\d$|^[0-9]$)';%001-139 - Others
pattern{2} = '(^1[4-9]\d$|^2[0-3]\d$)';%140-239 - Neoplasms
pattern{3} = '^2[4-7]\d$';%240-279 - Others (except 250.xx and 250)
pattern{4} = '^28\d$';%280-289 - Others
pattern{5} = '(^29\d$|^3[0-1]\d$)';%290-319 - Others
pattern{6} = '^3[2-5]\d$';%320-359 - Others
pattern{7} = '^3[6-8]\d$';%360-389 - Others
pattern{8} = '(^39\d$|^4[0-5]\d$)';%390-459 - Circulatory
pattern{9} = '(^4[6-9]\d$|^5[0-1]\d$)';%460-519 - Respiratory
pattern{10} = '^5[2-7]\d$';%520-579 - Digestive
pattern{11} = '(^5[8-9]\d$|^6[0-2]\d$)';%580-629 - Genitourinary 
pattern{12} = '^6[3-7]\d$';%630-679 - Others
pattern{13} = '(^6[8-9]\d$|^70\d$)';%680-709 - Others
pattern{14} = '^7[1-3]\d$';%710-739 - Musculoskeletal
pattern{15} = '^7[4-5]\d$';%740-759 - Others
pattern{16} = '^7[6-7]\d$';%760-779 - Others
pattern{17} = '^7[8-9]\d$';%780-799 - Others
pattern{18} = '(^8\d\d$|^9\d\d$)';%800-999 - Injury
pattern{19} = '(^E*|^V*)'; %Others
pattern{20} = '^250[.]\d';%250.xx - Diabetes

for i=1:num_pattern
    A = regexp(num2str(str),pattern{i});
    if ~isempty(A)
        val = i;
        break;
    end
end

%Exceptions
if strcmp(str,'250')
    val = 20;
end

if strcmp(str,'785')
    val = 8;
end

if strcmp(str,'786')
    val = 9;
end

if strcmp(str,'787')
    val = 10;
end

if strcmp(str,'780') || strcmp(str,'781') || strcmp(str,'784') 
    val = 17;
end

if strcmp(str,'782')
    val = 13;
end

if strcmp(str,'788')
    val = 11;
end

%% Assign the 20 categories to 9 groups
grps = {'Circulatory','Respiratory','Digestive','Diabetes','Injury',...
    'Musculoskeletal','Genitourinary','Neoplasms','Others'};

others = [1,3,4,5,6,7,12,13,15,16,17,19];

%Circulatory
if val==8
    cat_val = 1;
end

%Respiratory
if val == 9
    cat_val = 2;
end

%Digestive
if val == 10
    cat_val = 3;
end

%Diabetes
if val==20
    cat_val = 4;
end

%Injury
if val==18
    cat_val = 5;
end

%Musketl
if val==14
    cat_val = 6;
end

%Genitourinary 
if val==11
    cat_val = 7;
end

%Neoplasms 
if val==2
    cat_val = 8;
end


if ismember(val,others)
  cat_val = 9;
end

if cat_val==0
    cat_val = 9;
end


end