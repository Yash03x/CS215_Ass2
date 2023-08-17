rng(0);
hold on;
N = [10, 100, 1000, 10000, 100000];
C = [1.6250, -1.9486; -1.9486, 3.8750];
[V, D] = eig(C);
for i = 1: 2
    D(i, i) = sqrt(D(i, i));
end
A = V * D * V';
mu = [1;2];
%----------------------------------------
%{
errors_avg = zeros(5, 100);
for i = 1: 5
    for t = 1: 100
        sum_avg = zeros(2,1);
        for j = 1: N(i)
            myrand = generate_random(A, mu);
            sum_avg = sum_avg + myrand;
        end
        avg_avg = sum_avg / N(i);
        mydist = norm(avg_avg - mu);
        val = mydist / sqrt(5);
        errors_avg(i, t) = val;
    end
end
%}
%boxplot(errors_avg');

%----------------------------------------

errors_cov = zeros(5, 100);
for i = 1: 5
    for t = 1: 100
        sum_cov = zeros(2,2);
        sum_mean = zeros(2,1);
        for j = 1: N(i)
            myrand = generate_random(A, mu);
            sum_cov = sum_cov + myrand * myrand';
            sum_mean = sum_mean + myrand;
        end
        sum_mean = sum_mean/N(i);
        sum_cov = sum_cov / N(i);
        sum_cov = sum_cov - sum_mean * sum_mean';
        val = norm(C - sum_cov, 'Fro') / norm(C, 'Fro');
        errors_cov(i, t) = val;
    end
end

boxplot(errors_cov');
%----------------------------------------
%{
points = zeros(2, 1000);
for i = 1: 100000
    myrand = generate_random(A, mu);
    points(1, i) = myrand(1,1);
    points(2, i) = myrand(2, 1);
end
x = [-4:5];
y = -x/sqrt(3) + 1/sqrt(3) + 2;
z = -sqrt(3) * x + sqrt(3) + 2;

scatter(points(1,:), points(2,:));
plot(x, y);
plot(x, z);
hold off;
%}

% Function to generate random matrix:
function myrand = generate_random(A, mu)
    x = zeros(2, 1);
    x(1,1) = randn();
    x(2,1) = randn();
    myrand = A * x + mu;
end