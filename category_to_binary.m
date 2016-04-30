function [new_cols] = category_to_binary(orig_col,missing_val,N,len)
if ~len
    vs = unique(orig_col);
    if strncmp(vs,missing_val,1)
        vs(strncmp(vs,missing_val,1)) = [];%Remove missing value from category list
    end
else
    vs = 1:len;
end
len = length(vs);
new_cols = zeros(N,len);%Columns replacing orig_col

cat = 1:len;
cat = strtrim(cellstr(num2str(cat'))');
B = uint16(categorical(orig_col,vs,cat));

for i=1:N
    if B(i,1) ~= 0
    new_cols(i,B(i,1)) = 1;
    end
end
end