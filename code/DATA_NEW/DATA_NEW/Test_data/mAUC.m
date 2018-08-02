file = xlsread('mAUC.xlsx');

diag = [];
for i = 1 : size(file, 1)
    num = floor(file(i, 4)+0.5)
    if(num == 1 || num == 7 || num == 9)
        diag(i, 1) = 1;
        diag(i, 2) = 0;
        diag(i, 3) = 0;
    end
    if(num == 2 || num == 4 || num == 8)
        diag(i, 1) = 0;
        diag(i, 2) = 1;
        diag(i, 3) = 0;
    end
    if(num == 3 || num == 5 || num == 6)
        diag(i, 1) = 0;
        diag(i, 2) = 0;
        diag(i, 3) = 1;
    end
end

for i = 1 : size(file, 1)
    for j = 1 : 3
        file(i,j) = floor(file(i,j) + 0.5);
    end
end

n = [0, 0, 0];
for i = 1 : size(file, 1)
    if(file(i,1) == 1) n(1,1) = n(1,1) + 1;
    end
    
    if(file(i,2) == 1) n(1,2) = n(1,2) + 1;
    end
    
    if(file(i,3) == 1) n(1,3) = n(1,3) + 1;
    end
end

wrong_pred = [0,0,0; 0,0,0];
for i = 1 : size(file, 1)
    if(file(i, 1) == 1)
        if(diag(i, 1) == 0)
            if(diag(i, 2) == 1) wrong_pred(1, 1) = wrong_pred(1, 1) + 1;
            else wrong_pred(2, 1) = wrong_pred(2, 1) + 1;
            end
        end
    end
    
    if(file(i, 2) == 1)
        if(diag(i, 2) == 0)
            if(diag(i, 1) == 1) wrong_pred(1, 2) = wrong_pred(1, 2) + 1;
            else wrong_pred(2, 2) = wrong_pred(2, 2) + 1;
            end
        end
    end
    
    if(file(i, 3) == 1)
        if(diag(i, 3) == 0)
            if(diag(i, 1) == 1) wrong_pred(1, 3) = wrong_pred(1, 3) + 1;
            else wrong_pred(2, 3) = wrong_pred(2, 3) + 1;
            end
        end
    end
end

wrong_pred = [0,23,5;
    20,0,76;
0, 11, 0];

ans = 0;
for i = 1 : 3
    for j = 1 : 3
        if(i==j) continue; end
        nn = n(1,i);
        mm = n(1,j);
        temp = (nn-wrong_pred(j,i))*(mm*2+nn+1+wrong_pred(j,i))/2;
        temp = temp - nn * (nn+1)/2;
        temp = temp ./ nn ./ mm
        ans = ans + temp;
    end
end
