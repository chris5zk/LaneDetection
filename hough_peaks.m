   function peaks = hough_peaks(H, varargin) % Variable length input arguments list
        % Find peaks in a Hough accumulator array.
        % Threshold (optional): Threshold at which values of H are considered to be peaks.
        % NHoodSize (optional): Size of the suppression neighborhood.
        % Parse input arguments
        p = inputParser; 
        addOptional(p, 'numpeaks', 1, @isnumeric);
        addParameter(p, 'Threshold', 0.5 * max(H(:)));
        addParameter(p, 'NHoodSize', floor(size(H) / 100.0) * 20 + 1); 
        parse(p, varargin{:});

        numpeaks = p.Results.numpeaks;
        threshold = p.Results.Threshold;
        nHoodSize = p.Results.NHoodSize;

        [M, N] = size(H);
        peaks = [];
        for m=1:numpeaks                                % Finding numpeaks's times.
            Hs = sort(H(:),'descend');
            pkval = Hs(1);                              % The largest num appeared in Accmulator array.
            if pkval >= threshold
                [r,theta] = find(H==pkval,1);           % Record the houghpeak in temp value.
                % Suppression
                lowX = max([floor(r-nHoodSize(1)) 1]);
                highX = min([ceil(r+nHoodSize(1)) M]);
                lowY = max([floor(theta-nHoodSize(2)) 1]);
                highY = min([ceil(theta+nHoodSize(2)) N]);
                H(lowX:highX,lowY:highY) = 0;
                peaks = [peaks; r, theta];              % output size : peaks x 2 matrix.
            end
        end
    end