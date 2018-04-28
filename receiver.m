%signal
signal(n) = -42.0831;

%Set up initial condition
x = zeros(100);
y = zeros(100);
z = zeros(100);

x(1) = 10;
y(1) = 10;
z(1) = 10;

%Set up parameters
s = 10;
r = 28;
b = 8/3;
A = 0.01;
dt = 0.01;

%transmitter
for n = 1:99
    
    dx(n) = s*(y(n)-x(n));
    dy(n) = (1/A)*(signal(n)) - r*x(n) + y(n) + x(n)*z(n);
    dz(n) = x(n)*y(n) - b*z(n);
    
    x(n+1) = x(n) + dx(n)*dt;
    v_out = (1/A) * (dy(n) - r*x(n) + y(n) + x(n)*y(n)) * dt;
    z(n+1) = z(n) + dz(n)*dt;
    
end

v_out_final = v_out / dt