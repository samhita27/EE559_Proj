function [new_col] = category_to_num_pd(orig_col,missing_val,vs,cat)
% cat = strtrim(cellstr(num2str(cat'))');
new_col = uint16(categorical(orig_col,vs,cat))-1;

end