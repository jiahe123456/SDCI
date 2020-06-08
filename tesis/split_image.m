clear all
t=tic;
data=load('/home/ruben4181/20170524_I_PAN.mat');

matrix=data.I_PAN;

timeReading=toc(t);
fprintf('Time Reading= %.2f [sec]\n', timeReading);

t=tic;

sub_matrix=cell(7,7);
dimen=2048;

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
        sub_I_MS=sub_matrix{i,j};
        is=int2str(i);
        js=int2str(j);
        filename = strcat('/home/ruben4181/splited_pan_20170524/', is, '_', js);
        save(filename, 'sub_I_MS', '-v7.3');
    end
end

timeSaving=toc(t);
fprintf('Time saving = %.2f [sec]\n', timeSaving);
clear all
load handel
sound(y, Fs);