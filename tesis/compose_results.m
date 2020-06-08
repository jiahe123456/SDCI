function results = compose_results(varargin)
    N=1;
    M=7;
    results=uint16(zeros(N, M));
    for i=1:nargin-2
        data=load(varargin{i});
        spectral = data.spectral_info;
        [n, ~] = size(spectral);
        tmp=results;
        results=uint16(zeros(N+n-1, 7));
        if i>1
            results(1:N-1, :)=tmp;
        end
        results(N:N+n-1, :) = spectral(:, :);
        N=N+n;
    end
    filename = strcat(varargin{nargin-1}, '/', varargin{nargin});
    save(filename, 'results', '-v7.3');
end