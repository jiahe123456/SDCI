function convertAllOK(ALLOK_FILENAME, OUT_FILENAME)
filename=ALLOK_FILENAME;
load(filename);
[L, ~]=size(allOK);
lonLat=cell(L, 2);

for i=1:L
    lonLat{i, 1}=allOK{i, 1}{1};
    lonLat{i, 2}=allOK{i, 1}{2};
end
save(OUT_FILENAME, 'lonLat', '-v7.3');
end