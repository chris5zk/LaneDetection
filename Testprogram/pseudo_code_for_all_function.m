clear
close all
I = imread('TestImages/sample_lane.jpeg');
I = rgb2gray(I);
Ih = homfilt(I,128,2,0.5,2);
im = I,cutoff = 128,order,lowgain,highgain
imshow(Ih);

%function out = homfilt(im,cutoff,order,lowgain,highgain)
u = im2uint8(im);
%[r,c] = size(u);

height = size(im,1);
width = size(im,2);
[x,y] = meshgrid(-floor(width/2):floor(width-1/2), ...
                 -floor(height/2):floor(height-1/2));
lbutter = 1./(1+(sqrt(2)-1)*((x.^2+y.^2)/cutoff^2).^order);

u(find(u==0)) = 1;
lg = log(double(u));
ft = fftshift(fft2(lg));
hboost = lowgain + (highgain - lowgain) * (1-lbutter);
b = hboost.*ft;
ib = abs(ifft2(b));
out = exp(ib);

%end