function [x, y] = find_vanishing_point(peaks, u, hw)
    % Find vanishing point using two lines from hough peaks
    % peaks: two peaks from hough peaks
    % u: unique r table
    % hw: size of the image
    r1 = u(peaks(1, 1));
    the1 = peaks(1, 2) - 1;
    r2 = u(peaks(2, 1));
    the2 = peaks(2, 2) - 1;
    % scan the whole image and find the coordinate of intersection of two dominant lines
    for i = 2 : hw(1)-1
        for j = 2 : hw(2)-1
            t1 = (i-1:i+1)*cosd(the1) + (j-1:j+1)*sind(the1);
            t2 = (i-1:i+1)*cosd(the2) + (j-1:j+1)*sind(the2);
            if ismember(r1, ceil(t1)) && ismember(r2, ceil(t2))
                x = i;
                y = j;
                return;
            end
        end
    end
end