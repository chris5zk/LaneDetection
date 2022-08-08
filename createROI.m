function p_mask = createROI(p_canny, p_filter)
    % Create ROI dynamically with the threshold of otsu
    % p_canny: edge image
    % p_filter: gray image
    [h,w] = size(p_filter);
    mask = ones(h,w);
    t = graythresh(p_filter)*255;       % find the threshold
    for i = h:-1:1
        if mean(p_filter(i,:)) > t      % find the row greater than threshold
            break;
        end
    end
    mask(1:i + floor((h-i)/10),:) = 0;  % Interest in the Lane
    mask = mask > 0;
    p_mask = p_canny & mask;            % ROI
end