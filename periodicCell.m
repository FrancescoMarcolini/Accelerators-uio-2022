L=53.45; %m half period of fodo lattice
f=38;%m
N=100; %steps moving the "window"
z=linspace(1,53.45*4,2*N); %m longitudinal coordinate
%% horizontal plane

MF=[1 0; -1/f 1];
MD=[1 0; 1/f 1];
ML=[1 L; 0 1];

O=ones(2,2*N);
for i=1:N
    Mia=[1 i*L/N; 0 1];
Mib=[1 (1-i/N)*L; 0 1 ];
M=Mia*MF*ML*MD*Mib;
  phi=acos((M(1,1)+M(2,2))/2);
  a=(M(1,1)-M(2,2))/(2*sin(phi));
  b=M(1,2)/sin(phi);
    O(:,i)=[a ; b];
end %for

for j=1:N
    Mja=[1 j*L/N; 0 1];
Mjb=[1 (1-j/N)*L; 0 1 ];
Mj=Mja*MD*ML*MF*Mjb;
  phi=acos((Mj(1,1)+Mj(2,2))/2);
  a=(Mj(1,1)-Mj(2,2))/(2*sin(phi));
  b=Mj(1,2)/sin(phi);
    O(:,j+N)=[a ; b];
end %for

fig1=plot(z,O(1,:));
title('\alpha_x(s)')
%%
fig2=plot(z, O(2,:));
title('\beta_x(s)')
%% vertical plane
 %changing plane results in inverting F/D effect
MF=[1 0; 1/f 1];
MD=[1 0; -1/f 1];
V=ones(2,2*N);
for i=1:N
    Mia=[1 i*L/N; 0 1];
Mib=[1 (1-i/N)*L; 0 1 ];
M=Mia*MF*ML*MD*Mib;
  phi=acos((M(1,1)+M(2,2))/2);
  a=(M(1,1)-M(2,2))/(2*sin(phi));
  b=M(1,2)/sin(phi);
    V(:,i)=[a ; b];
end
for j=1:N
    Mja=[1 j*L/N; 0 1];
Mjb=[1 (1-j/N)*L; 0 1 ];
Mj=Mja*MD*ML*MF*Mjb;
  phi=acos((Mj(1,1)+Mj(2,2))/2);
  a=(Mj(1,1)-Mj(2,2))/(2*sin(phi));
  b=Mj(1,2)/sin(phi);
    V(:,j+N)=[a ; b];
end %for
fig3=plot(z,V(1,:));
title('\alpha_y(s)')
%%
fig2=plot(z, V(2,:));
title('\beta_y(s)')