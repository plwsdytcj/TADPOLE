Input = fopen('TADPOLE_TargetData_test.csv');
title = textscan(Input, '%s %s %s %s %s %s %s %s',1,'delimiter',',');
data = textscan(Input, '%s %f %f %f %f %f %f %f','delimiter',',');
fclose(Input);
a={};
t={};
for i = 1 :  size(data, 2)
    t = [t, title{1, i}(1, 1)];
end
A = {};
for j = 1 : size(data{1,1}, 1)
    a = {};
    count1 = 0;
    count2 = 0;
    for i = 1 :  size(data, 2)
        if(i >= 3 && i <= 5 && isnan(data{1,i}(j,1))) 
            count1 = 1;
        end
        if(i >= 6 && i <= 8 && isnan(data{1,i}(j,1))) 
            count2 = 1;
        end
        a = [a, data{1, i}(j, 1)];
    end
    if(count1 == 0 )
        A = [A; a];
    end
end
%xlswrite('output.csv', a{1}, 'A1');
%A = [{'12sss',2,3};{4,5,6}]
B = cell2table(A(1:end, :), 'VariableNames', t);
writetable(B, 'output_test_target111.csv', 'WriteRowNames', true);