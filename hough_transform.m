function [H, u] = hough_transform(p)
    % Calculate accumulator array of hough transform
    % p: image
    % Return H: accumulator array u: unique r table
    [x,y] = find(p==1);
    th = 0:179; cos_th = cosd(th) ; sin_th = sind(th);
    rtable = floor(x*cos_th+y*sin_th);
    u = unique(rtable);
    N = length(u);
    H = zeros(N, 180);
    for j= [20:90 92:160]
        for i= 1:N
            H(i,j) = length(find(rtable(:,j)==u(i)));       % accumulator array
        end
    end
end