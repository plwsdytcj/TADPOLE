clear;
Input = fopen('TADPOLE_InputData.csv');

a = '%s'
for i = 2 : 706
    a = strcat(a, ' %s');
end

title = textscan(Input, a,1,'delimiter',',');
data = textscan(Input, a,'delimiter',',');
fclose(Input);
num = 1;
result = [];
for i = 1 : size(data, 2)
    temp = data{1, i};
    count = 0;
    for j = 1 : size(temp, 1)
        %strcmp(data{1, 4}(2,1), {''})
        if (strcmp(temp(j, 1), {''}))
            count = count + 1;
        end
    end
    
    if(count / size(temp, 1) >= 0.7) result{num} = title{1, i};
        num = num + 1;
    end
end

result