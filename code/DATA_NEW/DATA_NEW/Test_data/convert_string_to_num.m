clear;
Input = fopen('after_impute_and_select.csv');

a = '%f %s %f %s %f %s %s %s';
for i = 9 : 338
    a = strcat(a, ' %f');
end
b = '%s';
for i = 2 : 338
    b = strcat(b, ' %s');
end
title = textscan(Input, b,1,'delimiter',',');
data = textscan(Input, a,'delimiter',',');
fclose(Input);


for i = 1 : size(data{1,1}, 1)
    if(strcmp(data{1, 4}(i, 1), 'Female'))
        data{1,4}(i,1) = {'1'};
    else
        data{1,4}(i,1) = {'2'};
    end
end
        
for i = 1 : size(data{1,1}, 1)
    if(strcmp(data{1, 6}(i, 1), 'Not Hisp/Latino'))
        data{1,6}(i,1) = {'1'};
    elseif(strcmp(data{1, 6}(i, 1), 'Hisp/Latino'))
        data{1,6}(i,1) = {'2'};
    else data{1,6}(i,1) = {'0'};
    end
end

for i = 1 : size(data{1,1}, 1)
    if(strcmp(data{1, 7}(i, 1), 'Black'))
        data{1,7}(i,1) = {'1'};
    elseif(strcmp(data{1, 7}(i, 1), 'White'))
        data{1,7}(i,1) = {'2'};
    elseif(strcmp(data{1,7}(i,1), 'More than one'))
        data{1,7}(i,1) = {'3'};
    else data{1,7}(i,1) = {'4'};
    end
end

for i = 1 : size(data{1,1}, 1)
    if(strcmp(data{1, 8}(i, 1), 'Married'))
        data{1,8}(i,1) = {'1'};
    elseif(strcmp(data{1, 8}(i, 1), 'Divorced'))
        data{1,8}(i,1) = {'2'};
    elseif(strcmp(data{1,8}(i,1), 'Widowed'))
        data{1,8}(i,1) = {'3'};
    else data{1,8}(i,1) = {'4'};
    end
end

Input = fopen('after_impute_target.csv');

a = '%s %f %f %f %f %f %f %f';

b = '%s';
for i = 2 : 8
    b = strcat(b, ' %s');
end
title1 = textscan(Input, b,1,'delimiter',',');
data1 = textscan(Input, a,'delimiter',',');
fclose(Input);

A = {};
for i = 1 : size(data{1,1}, 1)
    a = {};
    for j = 1 : size(data, 2)
        a = [a, data{1, j}(i, 1)];
    end
    
    count = 0;
    for k = 1 : size(data1{1,1}, 1)
        if(data1{1,2}(k,1) == data{1,1}(i,1))
            A = [A; a];
        end
    end
end

t={};
for i = 1 :  size(data, 2)
    t = [t, title{1, i}(1, 1)];
end

B = cell2table(A(1:end, :), 'VariableNames', t);
writetable(B, 'input_same_size.csv', 'WriteRowNames', true);


