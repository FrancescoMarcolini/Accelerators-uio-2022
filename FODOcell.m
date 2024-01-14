% simulation FODO cell
L=53.45; %m
f=38;%m
z=linspace(1,53.45*8,8);
M=[1-L^2/(2*f^2) 2*L*(1+L/(2*f)) ;  -L*(1-L/(2*f))/(2*f^2)  1-L^2/(2*f^2)];
x0=1e-3;
xp0=0;
X0=[x0; xp0];

X1=M*X0;
X2=M*X1;
X3=M*X2;
X4=M*X3;
X5=M*X4;
X6=M*X5;
X7=M*X6;
     x=[X0(1,1) X1(1,1) X2(1,1) X3(1,1) X4(1,1) X5(1,1) X6(1,1) X7(1,1)];
     
     plot(z,x, '-o');
     