x = zeros(1,10000000);
y = zeros(1,10000000);

for i = 1: 10000000
    myrand = random_ellipse();
    x(i) = myrand(1,1);
    y(i) = myrand(2,1);
end
figure;
histogram2(x, y, 'DisplayStyle', 'tile');

transform = [pi, pi/3; 0, exp(1)];
for i = 1: 10000000
    myrand = random_triangle(transform);
    x(i) = myrand(1,1);
    y(i) = myrand(2,1);
end
figure;
histogram2(x, y, 'DisplayStyle', 'tile');



function myrand = random_ellipse()
    r = sqrt(rand());
    theta = 2 * pi * rand();
    myrand = zeros(2,1);
    myrand(1,1) = 2 * r * cos(theta);
    myrand(2,1) = r * sin(theta);
end

function myrand = random_triangle(transform)
    myrand = zeros(2,1);
    myrand(1,1) = rand();
    myrand(2,1) = rand();
    myrand = transform * myrand;
    p = myrand(1,1);
    q = myrand(2,1);
    if (2 * pi * q + 3 * exp(1) * p > 3 * exp(1) * pi)
        myrand(1,1) = 4 * pi/3 - p;
        myrand(2,1) = exp(1) - q;
    end
end