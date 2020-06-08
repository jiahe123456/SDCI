%File used to prepare booth images (PAN and MS) to the BDSD Pansharpening
%Algorithm. The final result of this will be the maximun number of images
%of 1024x1024 and 2048x20148 pixels from the original MS and PAN images
clear;
clc;

t=tic;
%Read Band 8 (Panchromatic Image) and load the MultiSpectral Image from
%Matlab file (Bands from 1 to 7)

%Panchromatic tiff path
PAN_FileName='/media/ruben4181/Games/Caqueta/LC08_L1TP_008059_20170125_20170311_01_T1/LC08_L1TP_008059_20170125_20170311_01_T1_B8.TIF';
MS_FileName='/home/ruben4181/Caqueta_MS_I_20170125.mat';
basePANFileName='/media/ruben4181/Games/Caqueta/Splited_20170125/PAN/';
baseMSFileName='/media/ruben4181/Games/Caqueta/Splited_20170125/MS/';

fprintf('Starting to reading the PAN image\n');
[PAN_I, ~]=geotiffread(PAN_FileName);

fprintf('Time reading: %.2f [sec]\n', toc(t));

t=tic;

fprintf('Starting to splitting PAN image\n');

sub_matrix=cell(7,7); %The maximun number of subimages of 2048x2048 pixels at Panchromatic image
dimen=2048; %The dimension of a subimage at Panchromatic scale for pansharpening BDSD algorithm

for i=0:6
    for j=0:6
        sub_matrix{i+1, j+1}=PAN_I((1+i*dimen):(dimen*(i+1)), (1+j*dimen):(dimen*(j+1)), :);
    end
end

fprintf('Time splitting PAN image = %.2f [sec]\n', toc(t));

t=tic;

fprintf('Starting to save PAN subimages\n');

clear PAN_I;

t=tic;

for i=1:7
    for j=1:7
        sub_I_PAN=sub_matrix{i,j};
        is=int2str(i);
        js=int2str(j);
        filename = strcat(basePANFileName, is, '_', js);
        save(filename, 'sub_I_PAN', '-v7.3');
    end
end

clear;

t=tic;

fprintf('Starting to reading MS Image\n');

%Name of the Multi-Spectral matlab file pre-loaded before


DATA_MS_I=load(MS_FileName);

MS_I=DATA_MS_I.MS_I;
clear DATA_MS_I;

fprintf('MS Image readed succesfuly in %.2f [sec]\n', toc(t));

t=tic;

fprintf('Starting to splitting Multi-Spectral image\n');

sub_matrix=cell(7,7); %The maximun number of subimages of 2048x2048 pixels at Panchromatic image
dimen=1024; %The dimension of a subimage at Panchromatic scale for pansharpening BDSD algorithm

for i=0:6
    for j=0:6
        sub_matrix{i+1, j+1}=MS_I((1+i*dimen):(dimen*(i+1)), (1+j*dimen):(dimen*(j+1)), :);
    end
end

fprintf('Splitted MS Image in %.2f [sec]', toc(t));

fprintf('Starting to save PAN subimages\n');

t=tic;

for i=1:7
    for j=1:7
        sub_I_MS=uint16(sub_matrix{i,j});
        is=int2str(i);
        js=int2str(j);
        filename = strcat(baseMSFileName, is, '_', js);
        save(filename, 'sub_I_MS', '-v7.3');
        fprintf('Now: %d, $d', i, j);
    end
end

fprintf('Time saving MS image = %.2f [sec]\n', toc(t));

clear;