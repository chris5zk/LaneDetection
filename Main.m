%%% 2022/01/12
%%% Final Project:Lane detection
%%% members:408415002 408415005 408420083
%%% HAPPY NEW YEAR!
clear
close all

% Successful Images
I = imread('TestImages/sample_lane.jpeg');
lane_detection(I);
I2 = imread('TestImages/solidWhiteRight.jpg');
lane_detection(I2);
I3 = imread('TestImages/solidYellowCurve2.jpg');
lane_detection(I3);
I4 = imread('TestImages/solidYellowCurve.jpg');
lane_detection(I4);
I5 = imread('TestImages/morning.jfif');
lane_detection(I5);
I6 = imread('TestImages/morning.JPG');
lane_detection(I6);
I7 = imread('TestImages/tunnel.jpg');
lane_detection(I7);
I8 = imread('TestImages/1562313451749_GK329VBHQ.3-1.jpg');
lane_detection(I8);
I9 = imread('TestImages/Tester.png');
lane_detection(I9);
I10 = imread('TestImages/nighttest3.JPG');
lane_detection(I10);
I11 = imread('TestImages/night2.JPG');
lane_detection(I11);

% Failure Images
I12 = imread('TestImages/NationalHighway.jpg');
lane_detection(I12);
% I13 = imread('TestImages/night3.JPG');
% lane_detection(I13);

