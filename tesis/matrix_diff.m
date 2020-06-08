function delta = matrix_diff(A, DIR)
% For longitude uses  'X' as DIR option and for latitude use anyother
% string

delta=0;

[N, M]=size(A);
if strcmp(DIR, 'X')
    Diff=zeros(N, M-1);
    for i=1:N
        for j=1:M-1
            Diff(i, j)=abs(A(i, j)-A(i, j+1));
        end
    end
    delta=max(max(Diff));
else
    Diff=zeros(N-1, M);
    for i=1:N-1
        for j=M
            Diff(i, j)=abs(A(i, j)-A(i+1, j));
        end
    end
    delta=max(max(Diff));
end
end