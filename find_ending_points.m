function ij = find_ending_points(r, theta, p)
    % Find start & end points of the line (r, theta)
    % r: hough transform r of the line
    % theta: hough transform theta of the line
    % p: the edge image
    
    r_points_i = [];
    r_points_j = [];
    [h, w] = size(p);
    for i = 1 : h
        for j = 6 : w-5
            t = i*cosd(theta) + j*sind(theta);
            if (ceil(t) == r) && ( ismember(1,p(i, j-5:j+5)) ) 
                r_points_i = [r_points_i, i];
                r_points_j = [r_points_j, j];
            end
        end
    end
    
    min_j = find(r_points_j == min(r_points_j(:)), 1);
    max_j = find(r_points_j == max(r_points_j(:)), 1);
    ij = [r_points_i(min_j), r_points_j(min_j);
          r_points_i(max_j), r_points_j(max_j)];
    if ij(1, 1) > ij(2, 1)
        ij(1, 1) = h;
        ij(1, 2) = ceil((r - h*cosd(theta)) / sind(theta));
    else
        ij(2, 1) = h;
        ij(2, 2) = ceil((r - h*cosd(theta)) / sind(theta));
    end
end
