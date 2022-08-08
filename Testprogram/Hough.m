clear
close all
p_org = imread('sample_lane.jpeg');
p_gray = rgb2gray(p_org);
figure(1),imshow(p_org),title('Original');
figure(2),imshow(p_gray),title('Gray scale');
% Canny edge
p_canny = edge(p_gray, 'canny', [50 100] / 255, 0.1);
figure(3), imshow(p_canny), title('Canny');

[h,w] = size(p_gray);
x = [1,w/2-40,w/2+40,w];
y = [h,h/2,h/2,h];
mask = poly2mask(x,y,h,w);
p_mask = p_canny & mask;
figure(4),imshow(p_mask),title('P mask');


% for i = 1: h
%     for j = 1 : w 
%         if p_mask(i,j) == 1
%             p_org(i,j,:) = [255,0,0];
%         end
%     end
% end
% figure(5),imshow(p_org),title('finish');

[x,y] = find(p_mask==1);
th = 0:179; cos_th = cosd(th); sin_th = sind(th);
rtable = ceil(x*cos_th+y*sin_th);
u = unique(rtable);
N = length(u);
for j= 1:180
    for i= 1:N
        h(i,j) = length(find(rtable(:,j)==u(i)));
    end
end
figure(6),imshow(uint8(h));
f = maxk(h(:), 30);
a = [];
for i = 1:length(f)
    [r, theta] = find(h == f(i));
    r = u(r(1));
    theta = theta(1) - 1;
    flag = 0;
    for j = 1:length(a)
        if abs(theta - a(j)) < 2
            flag = 1;
            break;
        end
    end
    if flag == 0
        a(length(a) + 1) = theta;
	    p_mask = drawline(r,theta,p_mask);
    end
end
figure(7),imshow(p_mask);

