clear all;
close all;

%This is input value
input = 105;

%deal with input

input_message = 'Hi this is our secret message ';

for i=1:length(input_message)
    input_message_num(i) = 0 + (input_message(i));
end

%Set up initial condition
x(1) = 25;  X(1) = 11;
y(1) = 25;  Y(1) = 11;
z(1) = 25;  Z(1) = 11;
t(1) = 0;   T(1) = 0;

%Set up parameters
s = 10;
r = 21;
b = 8/3;
A = 10^(-2);
dt = 0.01;

%transmitter with some strange method
for n = 1:2000
    
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
    y(n+1)=y(n)+(1/6)*(yk1(n)+2*yk2(n)+2*yk3(n)+yk4(n))*dt;
    z(n+1)=z(n)+(1/6)*(zk1(n)+2*zk2(n)+2*zk3(n)+zk4(n))*dt;
   
    t(n+1) = t(n) + dt;
    
end

%add message to y
for i = 1:length(input_message_num) 
    y(999 + i) = y(999 + i) + input_message_num(i) .* A;
end




%receiver with euler forward method

for n = 1:2000
    
    Xk1(n)=s*(Y(n)-X(n));
    Yk1(n)=r*x(n)-Y(n)-x(n)*Z(n);
    Zk1(n)=X(n)*Y(n)-b*Z(n);

    Xk2(n)=s*((Y(n)+0.5*dt*Yk1(n))-(X(n)+0.5*dt*Xk1(n)));
    Yk2(n)=r*(x(n)+0.5*dt*Xk1(n))-(Y(n)+0.5*dt*Yk1(n))-(x(n)+0.5*dt*Xk1(n))*(Z(n)+0.5*dt*Zk1(n));
    Zk2(n)=(X(n)+0.5*dt*Xk1(n))*(Y(n)+0.5*dt*Yk1(n))-b*(Z(n)+0.5*dt*Zk1(n));

    Xk3(n)=s*((Y(n)+0.5*dt*Yk2(n))-(X(n)+0.5*dt*Xk2(n)));
    Yk3(n)=r*(x(n)+0.5*dt*Xk2(n))-(Y(n)+0.5*dt*Yk2(n))-(x(n)+0.5*dt*Xk2(n))*(Z(n)+0.5*dt*Zk2(n));
    Zk3(n)=(X(n)+0.5*dt*Xk2(n))*(Y(n)+0.5*dt*Yk2(n))-b*(Z(n)+0.5*dt*Zk2(n));

    Xk4(n)=s*((Y(n)+dt*Yk3(n))-(X(n)+0.5*dt*Xk3(n)));
    Yk4(n)=r*(x(n)+0.5*dt*Xk3(n))-(Y(n)+dt*Yk3(n))-(X(n)+0.5*dt*Xk3(n))*(Z(n)+0.5*dt*Zk3(n));
    Zk4(n)=(X(n)+0.5*dt*Xk3(n))*(Y(n)+dt*Yk3(n))-b*(Z(n)+0.5*dt*Zk3(n));

    X(n+1)=X(n)+(1/6)*(Xk1(n)+2*Xk2(n)+2*Xk3(n)+Xk4(n))*dt;
    Y(n+1)=Y(n)+(1/6)*(Yk1(n)+2*Yk2(n)+2*Yk3(n)+Yk4(n))*dt;
    Z(n+1)=Z(n)+(1/6)*(Zk1(n)+2*Zk2(n)+2*Zk3(n)+Zk4(n))*dt;
   
    T(n+1) = T(n) + dt;
    
end


for i=1:2000
    decryptarray(i) = y(i) - Y(i);
end

for i = 1:length(input_message_num)
    answer_array(i) = decryptarray(999 + i)./A;
end

% convert array of float to int
message_as_int = int8(answer_array)

answer = char(message_as_int)