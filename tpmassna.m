% This has the same equations as the Auto Fortran file

function M = tpmassna(t,y)

global par;

% rotor properties
Omega = par(1);
Jt = par(2);

% autobalancer properties
m1 = par(7);
m2 = par(8);
m3 = par(9);
m4 = par(10);

z1 = par(11);
z2 = par(12);
z3 = par(13);
z4 = par(14);

M = zeros(16,16);
M(1,1)=1;
M(3,3)=1;
M(5,5)=1;
M(7,7)=1;
M(9,9)=1;
M(11,11)=1;
M(13,13)=1;
M(15,15)=1;

M(2,2) = 1+m1+m2+m3+m4;
M(2,8) = m1*z1+m2*z2+m3*z3+m4*z4;
M(2,10)= -m1*sin(Omega*t+y(9));
M(2,12)= -m2*sin(Omega*t+y(11));
M(2,14)= -m3*sin(Omega*t+y(13));
M(2,16)= -m4*sin(Omega*t+y(15));
M(4,4) = 1+m1+m2+m3+m4;
M(4,6) = -m1*z1-m2*z2-m3*z3-m4*z4;
M(4,10)= m1*cos(Omega*t+y(9));
M(4,12)= m2*cos(Omega*t+y(11));
M(4,14)= m3*cos(Omega*t+y(13));
M(4,16)= m4*cos(Omega*t+y(15));
M(6,4)= m1*z1+m2*z2+m3*z3+m4*z4;
M(6,6)= -Jt-m1*z1^2-m2*z2^2-m3*z3^2-m4*z4^2;
M(6,10)= m1*z1*cos(Omega*t+y(9));
M(6,12)= m2*z2*cos(Omega*t+y(11));
M(6,14)= m3*z3*cos(Omega*t+y(13));
M(6,16)= m4*z4*cos(Omega*t+y(15));
M(8,2)= m1*z1+m2*z2+m3*z3+m4*z4;
M(8,8)=  Jt+m1*z1^2+m2*z2^2+m3*z3^2+m4*z4^2;
M(8,10)= -m1*z1*sin(Omega*t+y(9));
M(8,12)= -m2*z2*sin(Omega*t+y(11));
M(8,14)= -m3*z3*sin(Omega*t+y(13));
M(8,16)= -m4*z4*sin(Omega*t+y(15));
M(10,2)= -sin(Omega*t+y(9));
M(10,4)= cos(Omega*t+y(9));
M(10,6)= -z1*cos(Omega*t+y(9));
M(10,8)= -z1*sin(Omega*t+y(9));
M(10,10)= 1;
M(12,2) =-sin(Omega*t+y(11));
M(12,4) =cos(Omega*t+y(11));
M(12,6) =-z2*cos(Omega*t+y(11));
M(12,8) =-z2*sin(Omega*t+y(11));
M(12,12)= 1;
M(14,2) =-sin(Omega*t+y(13));
M(14,4) =cos(Omega*t+y(13));
M(14,6) =-z3*cos(Omega*t+y(13));
M(14,8) =-z3*sin(Omega*t+y(13));
M(14,14)= 1;
M(16,2) =-sin(Omega*t+y(15));
M(16,4) =cos(Omega*t+y(15));
M(16,6) =-z4*cos(Omega*t+y(15));
M(16,8) =-z4*sin(Omega*t+y(15));
M(16,16)= 1;

