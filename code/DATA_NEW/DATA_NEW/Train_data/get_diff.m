Input = fopen('input_same_size.csv');

a = '%f %s %f %s %f %s %s %s';
for i = 9 : 337
    a = strcat(a, ' %f');
end

b = '%s';
for i = 2 : 337
    b = strcat(b, ' %s');
end

title = textscan(Input, b,1,'delimiter',',');
data = textscan(Input, a,'delimiter',',');
fclose(Input);
result = [];
for visit = 1 : size(data{1,1}, 1)
    One_Data = data{1,2}{visit, 1}; % get one data

    index = [-1, -1];
    for i = 1 : size(One_Data, 2)
        if(One_Data(1, i) == '/' && index(1,1) == -1) index(1,1) = i;
        else if(One_Data(1, i) == '/') index(1,2) = i;
            end
        end
    end
    month = str2num(One_Data(1, 1 : index(1,1)-1));
    day = str2num(One_Data(1, index(1,1)+1 : index(1,2)-1));
    year = str2num(One_Data(1, index(1,2)+1 : size(One_Data, 2)));
    time = year*10000 + month*100 + day;
    
    result(visit, 1) = time;
end

Input = fopen('output_train_target.csv');

a = '%s %f %f %f %f %f %f %f';
b = '%s';
for i = 2 : 8
    b = strcat(b, ' %s');
end

title1 = textscan(Input, b,1,'delimiter',',');
data1 = textscan(Input, a,'delimiter',',');
fclose(Input);

result1 = [];
for visit = 1 : size(data1{1,1}, 1)
    One_Data = data1{1,1}{visit, 1}; % get one data

    index = [-1, -1];
    for i = 1 : size(One_Data, 2)
        if(One_Data(1, i) == '/' && index(1,1) == -1) index(1,1) = i;
        else if(One_Data(1, i) == '/') index(1,2) = i;
            end
        end
    end
    month = str2num(One_Data(1, 1 : index(1,1)-1));
    day = str2num(One_Data(1, index(1,1)+1 : index(1,2)-1));
    year = str2num(One_Data(1, index(1,2)+1 : size(One_Data, 2)));
    time = year*10000 + month*100 + day;
    
    result1(visit, 1) = time;
end

diff = [];
diff_month = [];
diff_year = [];
for i = 1 : size(result, 1)
    diff_year = floor(result1(i,1) / 10000) - floor(result(i,1) / 10000);
    diff_month = floor( rem(result1(i,1), 10000) / 100) - floor( rem(result(i,1), 10000) / 100);

    diff(i,1) = diff_year * 12 + diff_month;
end

diff_mmse = [];
for i = 1 : size(result, 1)
    diff_mmse(i,1) = data1{1,8}(i,1) - data{1,13}(i,1);
end