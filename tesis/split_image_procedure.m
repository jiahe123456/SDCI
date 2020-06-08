function split_image_procedure(IM_DIR, SUB_SPLITED_DIR, DIMEN, I_TYPE)
t=tic;
data=load(IM_DIR);

if strcmp(I_TYPE, 'PAN')
    matrix=data.PAN_I;
else
    matrix=data.MS_I;
end

timeReading=toc(t);
fprintf('Time Reading= %.2f [sec]\n', timeReading);

t=tic;

sub_matrix=cell(7,7);
dimen=DIMEN;

for i=0:6
    for j=0:6
        sub_matrix{i+1, j+1}=matrix((1+i*dimen):(dimen*(i+1)), (1+j*dimen):(dimen*(j+1)), :);
    end
end

timeSplit=toc(t);
fprintf('Time splitting = %.2f [sec]\n', timeSplit);

clear matrix

t=tic;
for i=1:7
    for j=1:7
        if strcmp(I_TYPE, 'PAN')
            sub_I_PAN=sub_matrix{i,j};
        else
            sub_I_MS=sub_matrix{i, j};
        end
        is=int2str(i);
        js=int2str(j);
        filename = strcat(SUB_SPLITED_DIR, is, '_', js);
        if strcmp(I_TYPE, 'PAN')
            save(filename, 'sub_I_PAN', '-v7.3');
        else
            save(filename, 'sub_I_MS', '-v7.3');
        end
    end
end

timeSaving=toc(t);
fprintf('Time saving = %.2f [sec]\n', timeSaving);
clear
load handel
sound(y, Fs);