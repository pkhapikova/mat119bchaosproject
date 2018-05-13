function decrypted_message = chaos_receiver_v4(x,y)

X = x;
Y = y;

%Set up initial conditions: different from transmitter
X(1) = 11;
Y(1) = 11;
Z(1) = 11;
T(1) = 0;

%Set up parameters: same as transmitter
s = 10;
r = 21;
b = 8/3;
A = 10^(-2);
dt = 0.01;

%runge kutta receiver equations
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

%check to make sure message has been encrypted
for i=1:1000
    encrypted_message(i) = int8(Y(999+i)) + 85;
end

encrypted = char(encrypted_message)

for i=1:1999
    decrypt_array(i) = (y(i) - Y(i));
end

for i=1:1000
    if int8(decrypt_array(999+i)./A) ~= 0
        answer_array(i) = int8(decrypt_array(999+i)./A);
    end
end

% convert array of float to int

decrypted_message = char(answer_array);

end