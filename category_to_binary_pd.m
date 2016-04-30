function [new_cols] = category_to_binary_pd(orig_col,missing_val,N,vs)
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


