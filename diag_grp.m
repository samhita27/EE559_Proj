function cat_val = diag_grp(val)

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

end