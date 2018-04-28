%This is input value
input = 100;

%Set up initial condition
x(1) = 10;
y(1) = 10;
z(1) = 10;

%Set up parameters
s = 10;
r = 40;
b = 5;
A = 0.01;
dt = 0.01;

%transmitter
for n = 1:1000
    
    dx = s*(y(n)-z(n));
    dy = r*x(n)-y(n)-x(n)*z(n)+A*input;
    dz = x(n)*y(n)-b*z(n);
    x(n+1) = x(n) + dx*dt;
    y(n+1) = y(n) + dy*dt;
    z(n+1) = z(n) + dz*dt;
    
end
