clear
close all

I5 = imread('TestImages/NationalHighway.jpg');
lane_detection(I5);
I5 = imread('TestImages/night3.JPG');
lane_detection(I5);