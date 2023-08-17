% eigenvalues from 701 to 784

% x = zeros(784,1);

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



x = reshape(digits_train(:,:,1), [784, 1]);
%--------------------------------------------------
basis = zeros(784, 84, 10);
for n = 1: 10
    [V, D] = eig(Covariance(:,:,n));
    basis(:,:,n) = V(:, 701:784);
    x = Mean(:, n);
    coordinates = find_coordinates(basis, x);
    answer = zeros(784, 1);
    for i = 1: 84
        answer = answer + coordinates(i) * basis(:, i, n);
    end
    figure;
    imshow(reshape(answer/255, [28, 28]));
end
%--------------------------------------------------


% -----------------------------------------------------
% The required function is here %

function coordinates = find_coordinates(basis, x)
    coordinates = zeros(84);
    for i = 1: 84
        coordinates(i) = dot(basis(:, i), x) / (dot(basis(:, i), basis(:, i)));
    end
end

