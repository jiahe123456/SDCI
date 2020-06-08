clear;
clc;

t=tic;

%Here goes the filename of the nc files, the file to load the matrix of
%latitude and longitude

ncFilename='/media/ruben4181/Games/Caqueta/nc/LC08_L1TP_008059_20160311_20170328_01_T1.nc';

lon=ncread(ncFilename, 'lon');
[N, M]=size(lon);

fprintf('Longitude NC File readed on %.2f seconds\n', toc(t));

%Here goes the excel file that have the coords of each coca crop in the
%area
excelFilename='/media/ruben4181/Games/Caqueta/Centroides/centroides_caqueta_excel.xls';
data=xlsread(excelFilename);
[L, ~]=size(data);

%delta=1.1369e-07/2; delta caqueta
delta=1.3482e-04/2; %delta putumayo

count=0;

t=tic;

lonOK=cell(L, 2);

total=tic;

for i=1:L
    % 13 Columna con el valor "x" (longitud) del punto
    % 14 Columna con el valor "y" (latitud) del punto
    [x, y]=find(lon>=data(i, 13)-delta & lon <=(data(i, 13))+delta);
    if ~isempty(x)
        count=count+1;
        lonOK{count}={i, unique(x)};
    end
end

clear lon;

t=tic;

lat=ncread(ncFilename, 'lat');
[N, M]=size(lat);

fprintf('Latitude NC File readed on %.2f seconds\n', toc(t));

allOK=cell(L, 2);

%delta=2e-08; delta caqueta
%delta putumayo
delta=6.1670e-08/2;
count2=0;
clear y; 
for i=1:count
    if ~isempty(lonOK{count}{1})
        pos=lonOK{count}{1};
        [x, y]=find(lat>=data(pos, 14)-delta & lat <=(data(pos, 14))+delta);
        if ~isempty(x)
            count2=count2+1;
            unique(y)
            allOK{count2}={lonOK{i}{2}, unique(y)};
        end
    end
end

clear data;
clear lat;
clear lonOK;
load handel

fprintf('\n%d puntos encontrados exitosamente en %.2f segundos\n', toc(total), count2);
outFoldername='/media/ruben4181/Games/Caqueta/results';
outFilename='puntos_i_j_caqueta.mat';
outPath=strcat(outFoldername, outFilename);
save(outPath, 'allOK', '-v7.3');