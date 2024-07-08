function dy = tpna(t,y)

global par;

% angular velocity
Omega = par(1);

% rotor properties
Jt = par(2);
Jp = par(3);

%imbalance properties
epsilon = par(4);
chi = par(5);
beta = par(6);

% autobalancer properties
m1 = par(7);
m2 = par(8);
m3 = par(9);
m4 = par(10);

z1 = par(11);
z2 = par(12);
z3 = par(13);
z4 = par(14);

% spring and damping constants
k11 = par(15);     k33 = par(21);
k12 = par(16);     k34 = par(22);
k22 = par(17);     k44 = par(23);
c11 = par(18);     c33 = par(24);
c12 = par(19);     c34 = par(25);
c22 = par(20);     c44 = par(26);

cb  = par(27);

dy = zeros(16,1); % a column vector

dy(1)  = y(2);
dy(2)  = -c11*y(2)-c12*y(8)-k11*y(1)-k12*y(7)+Omega^2*epsilon*cos(Omega*t+beta)+m1*(Omega+y(10))^2*cos(Omega*t+y(9))+m2*(Omega+y(12))^2*cos(Omega*t+y(11))+m3*(Omega+y(14))^2*cos(Omega*t+y(13))+m4*(Omega+y(16))^2*cos(Omega*t+y(15));
dy(3)  = y(4);
dy(4)  = -c33*y(4)+c34*y(6)-k33*y(3)+k34*y(5)+Omega^2*epsilon*sin(Omega*t+beta)+m1*(Omega+y(10))^2*sin(Omega*t+y(9))+m2*(Omega+y(12))^2*sin(Omega*t+y(11))+m3*(Omega+y(14))^2*sin(Omega*t+y(13))+m4*(Omega+y(16))^2*sin(Omega*t+y(15));
dy(5)  = y(6);
dy(6)  = Omega*Jp*y(8)-c34*y(4)+c44*y(6)-k34*y(3)+k44*y(5)+Omega^2*chi*(Jt-Jp)*sin(Omega*t)+m1*(Omega+y(10))^2*z1*sin(Omega*t+y(9))+m2*(Omega+y(12))^2*z2*sin(Omega*t+y(11))+m3*(Omega+y(14))^2*z3*sin(Omega*t+y(13))+m4*(Omega+y(16))^2*z4*sin(Omega*t+y(15));
dy(7)  = y(8);
dy(8)  = -c12*y(2)-c22*y(8)+Omega*Jp*y(6)-k12*y(1)-k22*y(7)+Omega^2*chi*(Jt-Jp)*cos(Omega*t)+m1*(Omega+y(10))^2*z1*cos(Omega*t+y(9))+m2*(Omega+y(12))^2*z2*cos(Omega*t+y(11))+m3*(Omega+y(14))^2*z3*cos(Omega*t+y(13))+m4*(Omega+y(16))^2*z4*cos(Omega*t+y(15));
dy(9)  = y(10);
dy(10) = -cb*y(10);
dy(11) = y(12);
dy(12) = -cb*y(12);
dy(13) = y(14);
dy(14) = -cb*y(14);
dy(15) = y(16);
dy(16) = -cb*y(16);