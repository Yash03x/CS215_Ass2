%X = imread('../data/data_fruit/image_1.png');
rng(0);
Images = zeros(19200, 16);

Images(:, 1) = reshape(imread('image_1.png'), [19200,1]);
Images(:, 2) = reshape(imread('image_2.png'), [19200,1]);
Images(:, 3) = reshape(imread('image_3.png'), [19200,1]);
Images(:, 4) = reshape(imread('image_4.png'), [19200,1]);
Images(:, 5) = reshape(imread('image_5.png'), [19200,1]);
Images(:, 6) = reshape(imread('image_6.png'), [19200,1]);
Images(:, 7) = reshape(imread('image_7.png'), [19200,1]);
Images(:, 8) = reshape(imread('image_8.png'), [19200,1]);
Images(:, 9) = reshape(imread('image_9.png'), [19200,1]);
Images(:, 10) = reshape(imread('image_10.png'), [19200,1]);
Images(:, 11) = reshape(imread('image_11.png'), [19200,1]);
Images(:, 12) = reshape(imread('image_12.png'), [19200,1]);
Images(:, 13) = reshape(imread('image_13.png'), [19200,1]);
Images(:, 14) = reshape(imread('image_14.png'), [19200,1]);
Images(:, 15) = reshape(imread('image_15.png'), [19200,1]);
Images(:, 16) = reshape(imread('image_16.png'), [19200,1]);

Mean = zeros(19200, 1);
for i = 1: 16
    Mean = Mean + Images(:, i);
end
Mean = Mean/16;
%subplot(4, 3, 1);
imshow(reshape(Mean/255, [80,80,3]));


Covariance = zeros(19200, 19200, 'single');

for i = 1: 16
    Covariance = Covariance + (Images(:, i) - Mean) * (Images(:, i) - Mean)';
end
Covariance = Covariance/16;

[V, D] = eigs(double(Covariance), 10);

clear Covariance;
D = diag(D)';
%}

%{
x = 1:10;
plot(x, D,'-');

V = V(:, 1:4);
D = D(1:4);
for i = 1: 16
    figure;
    subplot(1,2,1);
    imshow(reshape(Images(:,i)/255, [80,80,3]));
    W = V' * (Images(:, i) - Mean);
    subplot(1,2,2);
    myImage = Mean + V * W;
    imshow(reshape(myImage/255, [80,80,3]));
end
%}
%{
figure;
for t = 1: 3
    myImage = sqrt(D(1)) * rand() * V(:,1) + sqrt(D(2)) * rand() * V(:,2) + sqrt(D(3)) * rand() * V(:,3) + sqrt(D(4)) * rand() * V(:,4);
    subplot(1, 3 ...
        , t);
    imshow(reshape(myImage/255, [80,80,3]));
end
%}
