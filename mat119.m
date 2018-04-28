%This is input value
input = 100;

%Set up initial condition
x(1) = 10;
y(1) = 10;
z(1) = 10;
t(1) = 0;

%Set up parameters
s = 10;
r = 28;
b = 8/3;
A = 10^(-12);
dt = 0.01;

%transmitter with some strange method
for n = 1:1000
    
    xk1(n)=s*(y(n)-x(n));
    yk1(n)=r*x(n)-y(n)-x(n)*z(n);
    zk1(n)=x(n)*y(n)-b*z(n);

    xk2(n)=s*((y(n)+0.5*dt*yk1(n))-(x(n)+0.5*dt*xk1(n)));
    yk2(n)=r*(x(n)+0.5*dt*xk1(n))-(y(n)+0.5*dt*yk1(n))-(x(n)+0.5*dt*xk1(n))*(z(n)+0.5*dt*zk1(n));
    zk2(n)=(x(n)+0.5*dt*xk1(n))*(y(n)+0.5*dt*yk1(n))-b*(z(n)+0.5*dt*zk1(n));

    xk3(n)=s*((y(n)+0.5*dt*yk2(n))-(x(n)+0.5*dt*xk2(n)));
    yk3(n)=r*(x(n)+0.5*dt*xk2(n))-(y(n)+0.5*dt*yk2(n))-(x(n)+0.5*dt*xk2(n))*(z(n)+0.5*dt*zk2(n));
    zk3(n)=(x(n)+0.5*dt*xk2(n))*(y(n)+0.5*dt*yk2(n))-b*(z(n)+0.5*dt*zk2(n));

    xk4(n)=s*((y(n)+dt*yk3(n))-(x(n)+0.5*dt*xk3(n)));
    yk4(n)=r*(x(n)+0.5*dt*xk3(n))-(y(n)+dt*yk3(n))-(x(n)+0.5*dt*xk3(n))*(z(n)+0.5*dt*zk3(n));
    zk4(n)=(x(n)+0.5*dt*xk3(n))*(y(n)+dt*yk3(n))-b*(z(n)+0.5*dt*zk3(n));

    x(n+1)=x(n)+(1/6)*(xk1(n)+2*xk2(n)+2*xk3(n)+xk4(n))*dt;
    y(n+1)=y(n)+(1/6)*(yk1(n)+2*yk2(n)+2*yk3(n)+yk4(n))*dt+A*input*dt;
    z(n+1)=z(n)+(1/6)*(zk1(n)+2*zk2(n)+2*zk3(n)+zk4(n))*dt;
    
    dydt(n)=(1/6)*(yk1(n)+2*yk2(n)+2*yk3(n)+yk4(n))+A*input;
    t(n+1) = t(n) + dt;
    
end


