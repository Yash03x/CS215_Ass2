load('../data/points2D_Set2.mat');
Mean = zeros(2,1);

for i = 1: 300
    Mean(1,1) = Mean(1,1) + x(i);
    Mean(2,1) = Mean(2,1) + y(i);
end
Mean = Mean/300;

Covariance = zeros(2,2);

for i = 1: 300
    temp = [x(i); y(i)];
    Covariance = Covariance + (temp - Mean) * (temp - Mean)';
end
Covariance = Covariance/300;

[V, D] = eig(Covariance);
D = diag(D)';

t = -2:0.01:2;
line = V(2,2)/V(1,2) * (t - Mean(1)) + Mean(2);

% The direction of the line is given by V(2)
figure;
hold on;
scatter(x, y);
plot(t, line);
hold off;