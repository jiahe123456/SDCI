clear;
lon=ncread('/media/ruben4181/Games/Putumayo/LC08_L1TP_008060_20160311_20170328_01_T1.nc', 'lon');
[N, M]=size(lon);

dif=zeros(N-1, M);

for j=1:M
    for i=1:N-1
        dif(i, j)=abs(lon(i, j)-lon(i+1, j));
    end
end
