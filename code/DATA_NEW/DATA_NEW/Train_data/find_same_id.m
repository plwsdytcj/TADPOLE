clear;
Input = fopen('TADPOLE_TargetData_trainCopy.csv');

a = '%s';
for i = 2 : 8
    a = strcat(a, ' %s');
end

title = textscan(Input, a,1,'delimiter',',');
data = textscan(Input, a,'delimiter',',');
fclose(Input);

Input = fopen('TADPOLE_InputData_deleted.csv');

a = '%s'
for i = 2 : 365
    a = strcat(a, ' %s');
end

title1 = textscan(Input, a,1,'delimiter',',');
data1 = textscan(Input, a,'delimiter',',');
fclose(Input);


a={};
t={};
for i = 1 :  size(data1, 2)
    t = [t, title1{1, i}(1, 1)];
end
A = {};
id = {'-1'};
for j = 1 : size(data{1,1}, 1)
    if(strcmp(id, data{1, 2}(j, 1))) continue;
    end
    id = data{1, 2}(j, 1)
    for k = 1 : size(data1{1, 1}, 1)
        if(strcmp(id, data1{1, 1}(k, 1)))
        a = {};
        for i = 1 :  size(data1, 2)
            a = [a, data1{1, i}(k, 1)];
        end
        A = [A; a];
        end
    end
end
%xlswrite('output.csv', a{1}, 'A1');
%A = [{'12sss',2,3};{4,5,6}]
B = cell2table(A(1:end, :), 'VariableNames', t);
writetable(B, 'output.csv', 'WriteRowNames', true);