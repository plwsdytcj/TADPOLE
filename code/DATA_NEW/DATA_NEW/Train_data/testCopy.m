Input = fopen('TADPOLE_TargetData_trainCopy.csv');
C = {};
A = {};
a = '%s';
for i = 2 : 8
    a = strcat(a, '%s');
end

b = '%f %s %f %f %f %f %f %f';


title = textscan(Input, a,1,'delimiter',',');
data = textscan(Input, b,'delimiter',',');
fclose(Input);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Id = data{1,1};
eachid = 1;
while eachid < size(Id, 1)
    sameid = eachid + 1;
        while(sameid <= size(Id, 1) && Id(sameid, 1) == Id(eachid, 1)) sameid = sameid + 1;
        end
    person = [];
    
    for select = 1 : size(data, 2)
        temp = data{1, select};
        person{select} = temp(eachid: sameid-1, 1);
    end
    
    %if(eachid == sameid - 1)
    %    eachid = sameid-1;
    %    eachid = eachid + 1;
    %    continue; 
    %end
    
    eachid = sameid-1;
    eachid = eachid + 1;
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
Person_Infor = person;   % each person

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert Exam Data into Number, Output is "time"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Exam_Data = Person_Infor{1,2}; % get dtat
Exam_Data_Num = [];
for visit = 1 : size(Exam_Data, 1)
    One_Data = Exam_Data{visit, 1}; % get one data

    %year = str2num(One_Data(1, size(One_Data, 2)-3 : size(One_Data, 2)));
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
    
    Exam_Data_Num(visit, 1) = time;
    
    [ma, I] = max(Exam_Data_Num);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert Exam Data into Number, Output is "time"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for coloum = 1 : size(Person_Infor, 2)
    Imputation = Person_Infor{1, coloum};
    if(~isnumeric(Imputation(1,1))) continue;
    end
    [eachid, coloum]
    X_regress = [ones(size(Exam_Data_Num, 1), 1) Exam_Data_Num];
    if(size(X_regress, 1) == 1)
        if(isnan(Imputation(1, 1))) Imputation(1,1) = 0;
        end
    else
    b = regress(Imputation, X_regress);
    for i = 1 : size(Imputation, 1)
        if(isnan(Imputation(i, 1)))
            Imputation(i, 1) = Exam_Data_Num(i, 1) * b(2,1) + b(1,1);
        end
    end
    end
    Person_Infor{1, coloum} = Imputation;
end

for out = 1 : size(Person_Infor{1,1}, 1)
    a = {};
    for out2 = 1 : size(Person_Infor, 2)
        a = [a, Person_Infor{1, out2}(out, 1)];
    end
    A = [A; a];
end
%Person_Infor

for out = I : I
    a = {};
    for out2 = 1 : size(Person_Infor, 2)
        a = [a, Person_Infor{1, out2}(out, 1)];
    end
    C = [C; a];
end

end

t={};
for i = 1 :  size(data, 2)
    t = [t, title{1, i}(1, 1)];
end

B = cell2table(A(1:end, :), 'VariableNames', t);
writetable(B, 'after_impute_target.csv', 'WriteRowNames', true);

%B = cell2table(C(1:end, :), 'VariableNames', t);
%writetable(B, 'after_impute_and_selectcopy_target.csv', 'WriteRowNames', true);
