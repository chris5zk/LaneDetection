clear
close all

p_org = imread('solidYellowCurve.jpg');
% figure,imshow(p_org),title('original');
p_filter = imgaussfilt3(p_org);
figure,imshow(p_filter),title('Gaussian Filtered Image');

% Masking the image for White and Yellow Color
% The frame is masked with yellow and white color to detect the lane lines perfectly.

% Define Thresholds for masking Yellow Color (HSV)
%-----Define thresholds for 'Hue'
channel1MinY = 130;
channel1MaxY = 255;
%-----Define thresholds for 'Saturation'
channel2MinY = 130;
channel2MaxY = 255;
%-----Define thresholds for 'Value'
channel3MinY = 0;
channel3MaxY = 130;

%Create mask based on chosen histogram thresholds
Yellow =((p_filter(:,:,1)>=channel1MinY)|(p_filter(:,:,1)<=channel1MaxY))& ...
    (p_filter(:,:,2)>=channel2MinY)&(p_filter(:,:,2)<=channel2MaxY)&...
    (p_filter(:,:,3)>=channel3MinY)&(p_filter(:,:,3)<=channel3MaxY);

figure,imshow(Yellow),title('Yellow Mask');

%Define Thresholds for masking White Color
%-----Define thresholds for 'Hue'
channel1MinW = 200;
channel1MaxW = 255;
%-----Define thresholds for 'Saturation'
channel2MinW = 200;
channel2MaxW = 255;
%-----Define thresholds for 'Value'
channel3MinW = 200;
channel3MaxW = 255;

%Create mask based on chosen histogram thresholds
White=((p_filter(:,:,1)>=channel1MinW)|(p_filter(:,:,1)<=channel1MaxW))&...
    (p_filter(:,:,2)>=channel2MinW)&(p_filter(:,:,2)<=channel2MaxW)& ...
    (p_filter(:,:,3)>=channel3MinW)&(p_filter(:,:,3)<=channel3MaxW);

figure,imshow(White),title('White Mask');

%Edge Detection
frameW = edge(White, 'canny', 0.2);
frameY = edge(Yellow, 'canny', 0.2);
frame = edge(rgb2gray(p_filter),'canny',[50 100] / 255,0.2);
frameW = bwareaopen(frameW,15); % bwareaopen : Remove small objects from binary image
frameY = bwareaopen(frameY,15); 
frame = bwareaopen(frame,15); 
figure,imshow(frameY),title('Detecting Edges of Yellow mask');
figure,imshow(frameW),title('Detecting Edges of White mask');
figure,imshow(frame),title('Detecting Edges');

%Deciding ROI region
[h,w] = size(p_filter);
w = w/3; % rgb's size 
x = [1,w/2,w];
y = [h,h/2+40,h];
mask = poly2mask(x,y,h,w); % triangle mask
frame_roiY = frameY & mask;
frame_roiW = frameW & mask;
frame = frame & mask;
figure,imshow(frame_roiY),title('Filtering ROI from Yellow mask');
figure,imshow(frame_roiW),title('Filtering ROI from White mask');
figure,imshow(imadd(frame_roiW,frame_roiY)),title('Y + W mask');
figure,imshow(frame),title('Filtering ROI from mask');

%hough transform
[H_Y,theta_Y,rho_Y] = hough(frame_roiY);
[H_W,theta_W,rho_W] = hough(frame_roiW);
%Extracting Hough Peaks from Hough Transform of frames
P_Y = houghpeaks(H_Y,2,'threshold',2);
P_W = houghpeaks(H_W,2,'threshold',2);

%-Plotting Hough Transform and detecting Hough Peaks
figure,imshow(imadjust(rescale(H_W)),[],'XData',theta_W,'YData',rho_W,'InitialMagnification','fit'),title('Hough Peaks for White Line');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal
hold on
colormap(gca,hot)

x = theta_W(P_W(:,2));
y = rho_W(P_W(:,1));
plot(x,y,'s','color','blue');
hold off

figure,imshow(imadjust(rescale(H_Y)),[],'XData',theta_Y,'YData',rho_Y,'InitialMagnification','fit'),title('Hough Peaks for Yellow Line');
xlabel('\theta (degrees)')
ylabel('\rho')
axis on
axis normal
hold on
colormap(gca,hot)

x = theta_W(P_Y(:,2));
y = rho_W(P_Y(:,1));
plot(x,y,'s','color','blue');
hold off

%Extracting Lines from Detected Hough Peaks
figure,imshow(p_filter),title('Hough Lines found in image'), hold on
lines_Y = houghlines(frame_roiY,theta_Y,rho_Y,P_Y,'FillGap',3000,'MinLength',20);
max_len = 0;
for k = 1:length(lines_Y)
   xy = [lines_Y(k).point1; lines_Y(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end

lines_W = houghlines(frame_roiW,theta_W,rho_W,P_W,'FillGap',3000,'MinLength',20);
max_len = 0;
for k = 1:2
   xy = [lines_W(k).point1; lines_W(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end
hold off