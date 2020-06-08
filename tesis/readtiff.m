clear;
clc;
fprintf('Starting to reading files\n');

Bands=7;
MS_Bands=cell(Bands);

[MS_Bands{1}, ~]=geotiffread('/media/ruben4181/Games/Putumayo/LC08_L1TP_008060_20171211_20171223_01_T1/LC08_L1TP_008060_20171211_20171223_01_T1_B1.TIF');
[MS_Bands{2}, ~]=geotiffread('/media/ruben4181/Games/Putumayo/LC08_L1TP_008060_20171211_20171223_01_T1/LC08_L1TP_008060_20171211_20171223_01_T1_B2.TIF');
[MS_Bands{3}, ~]=geotiffread('/media/ruben4181/Games/Putumayo/LC08_L1TP_008060_20171211_20171223_01_T1/LC08_L1TP_008060_20171211_20171223_01_T1_B3.TIF');
[MS_Bands{4}, ~]=geotiffread('/media/ruben4181/Games/Putumayo/LC08_L1TP_008060_20171211_20171223_01_T1/LC08_L1TP_008060_20171211_20171223_01_T1_B4.TIF');
[MS_Bands{5}, ~]=geotiffread('/media/ruben4181/Games/Putumayo/LC08_L1TP_008060_20171211_20171223_01_T1/LC08_L1TP_008060_20171211_20171223_01_T1_B5.TIF');
[MS_Bands{6}, ~]=geotiffread('/media/ruben4181/Games/Putumayo/LC08_L1TP_008060_20171211_20171223_01_T1/LC08_L1TP_008060_20171211_20171223_01_T1_B6.TIF');
[MS_Bands{7}, ~]=geotiffread('/media/ruben4181/Games/Putumayo/LC08_L1TP_008060_20171211_20171223_01_T1/LC08_L1TP_008060_20171211_20171223_01_T1_B7.TIF');

fprintf('Reading images succed\nStarting to creating Multi Spectral Matlab File\n');

N=7731;
M=7581;
MS_I=zeros(N, M, Bands);

for k=1:Bands
    for i=1:N
        for j=1:M
            MS_I(i, j, k)=MS_Bands{k}(i,j);
        end
    end
end

fprintf('Image created succesfuly, starting to save the Matlabfile\n');
save('/home/ruben4181/Putumayo_MS_I_20171211.mat', 'MS_I', '-v7.3');
fprintf('Data saved succesfuly\n');