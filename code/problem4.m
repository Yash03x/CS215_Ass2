load('../data/mnist.mat');
Covariance = zeros(784, 784, 10);
Mean = zeros(784, 10);
count = zeros(10, 1);

for i = 1: 60000
    n = labels_train(i) + 1;
    count(n) = count(n) + 1;
    X = reshape(digits_train(:,:,i), [784, 1]);
    Mean(:, n) = Mean(:, n) + double(X);
end

% Calculating Mean
for n = 1: 10
    for j = 1: 784
        Mean(j, n) = Mean(j, n)/count(n);
    end
end


% Calculating Covariance
for i = 1: 60000
    n = labels_train(i) + 1;
    X = reshape(digits_train(:,:,i), [784, 1]);
    temp = Mean(:, n);
    M = (double(X) - temp) * (double(X) - temp)';
    Covariance(:,:,n) = Covariance(:,:,n) + M;
end

for n = 1: 10
    Covariance(:,:,n) = Covariance(:,:,n)/count(n);
end


eigenvalues = zeros(n, 784);
eigenvectors = zeros(784, 10);

for n = 1: 10
    [V, D] = eig(Covariance(:,:,n));
    for i = 1: 784
        eigenvalues(n, i) = D(i,i);
    end
    eigenvectors(:, n) = V(:, 1);
end
eigenvalues = sort(eigenvalues, 2, 'descend');

lambda = zeros(10);
for i = 1: 10
    lambda(i) = sqrt(eigenvalues(i, 1));
end

for i = 1: 10
    figure;
    subplot(1,3,1);
    imshow(reshape(Mean(:,i)/255, [28,28]));
    subplot(1,3,2);
    imshow(reshape((Mean(:,i) - lambda(i) * eigenvectors(:,i))/255, [28,28]));
    subplot(1,3,3);
    imshow(reshape((Mean(:,i) + lambda(i) * eigenvectors(:,i))/255, [28,28]));
end