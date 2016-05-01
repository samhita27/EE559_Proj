pattern = {'^250[.]\d*'};%250.xx - Diabetes

arr = {'250.90','250.78','250'};

rep = {'250'};

D = regexprep(arr,pattern,rep);
