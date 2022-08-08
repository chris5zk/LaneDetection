function plot_hough_transform(P,H,N)    
    % Plotting Hough Transform and Hough Peaks
    % P: peaks from Hough peaks
    % H: accumulator array from Hough Transform
    % N: the length of the unique r table
    theta = zeros(1,180);
    for i = 1:180
        theta(1,i) = i-1; 
    end
    rho = zeros(1,N);
    for i = 1:N
        rho(1,i) = i;
    end
    figure,imshow(imadjust(rescale(H)),[],'XData',theta,'YData',rho,'InitialMagnification','fit'),title('Hough Peaks');
    xlabel('\theta (degrees)')
    ylabel('\rho')
    axis on
    axis normal
    hold on
    colormap(gca,hot)
    x = theta(P(:,2));
    y = rho(P(:,1));
    plot(x,y,'s','color','blue');
    hold off
end