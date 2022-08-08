function lane_detection(p_org)

    % Noise removal
    p_filter = imgaussfilt3(p_org);
    
    % Edge Detection
    p_filter = rgb2gray(p_filter);
    p_canny = edge(p_filter,'canny',[20 80]/255,0.1);
    
    % Deciding ROI region
    p_mask = createROI(p_canny,p_filter);

    % Hough transform
    % get H , unique r table
    [H, u] = hough_transform(p_mask);
    
    % Extracting Hough Peaks from Hough Transform of frames
    P = hough_peaks(H,2,'Threshold',20);
    N = length(u);
    plot_hough_transform(P,H,N);
    
    % Result image
    figure, imshow(p_org),title('Lanes detection');
    hold on;
    
    % Create new ROI mask with the vanishing point
    [i, j] = find_vanishing_point(P, u, size(p_mask));
    h = size(p_filter,1);
    plot(j, i, 'rO');
    new_mask = ones(size(p_mask));
    new_mask(1:i+floor((h-i)/10), :) = 0;
    p_new_mask = p_canny & new_mask;

    % Plot line on the original image
    for i = 1:size(P,1)
        r = u(P(i,1));
        the = P(i,2) - 1;
        if ( ((the>20)&&(the<88)) || ((the>92)&&(the<160)) )
            ij = find_ending_points(r, the, p_new_mask);
            plot(ij(:,2),ij(:,1),'LineWidth',3,'Color','green');
        end
    end
    
    hold off;
    
    % Process
    figure,
    subplot(231),imshow(p_org),title('original');
    subplot(232),imshow(p_filter),title('Gaussian Filtered Image');
    subplot(233),imshow(p_canny),title('Detecting Edges');
    subplot(234),imshow(p_mask),title('Filtering ROI from mask');
    subplot(235),imshow(p_new_mask),title('Filtering ROI with vanish point');
end
