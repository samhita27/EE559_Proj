function [new_col,len] = category_to_num(orig_col,missing_val)
vs = unique(orig_col);
if strncmp(vs,missing_val,1)
     vs(strncmp(vs,missing_val,1))= [];%Remove missing value from category list
end
len = length(vs);

cat = 1:len;
cat = strtrim(cellstr(num2str(cat'))');
new_col = uint16(categorical(orig_col,vs,cat));

end

