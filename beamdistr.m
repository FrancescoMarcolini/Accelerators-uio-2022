%twiss parameter at START
clear all;
clc;
bet=168000 ;%m
alf= -810  ;%m
eg=900e-9/3.7182e+05;%m divided by gamma
N=2e4;% number of particles

x1=ones(N,1);
x2=ones(N,1);


for i=1:N
    x1(i)=random('Normal',0,1);
    x2(i)=random('Normal',0,1);
end 

c11=sqrt(eg*bet);
c12=0;
r=-eg*alf/(c11*sqrt(eg*(1+alf^2)/bet));
c21=sqrt(eg*(1+alf^2)/bet)*r;
c22=sqrt(eg*(1+alf^2)/bet)*sqrt(1-r^2);

x=c11*x1;
px=c21*x1+c22*x2;
fig1=scatter(x,px);
hold on
%now estimate the twiss parameters from the distribution
S=cov(x,px);
alfx1=-S(1,2)/sqrt(S(1,1)*S(2,2)-S(1,2)^2);
betx1=-alfx1*S(1,1)/S(1,2);
eg1=S(1,1)/betx1;
errbet1=abs(betx1-bet)/bet; %relative error on the estimate 
erreg1=abs(eg1-eg)/eg;
%% for y direction 
egy=20e-9/3.7182e+05; %input twiss parameters in y dir
bety=137e3;
alfy=-653;

cy11=sqrt(egy*bety);
ry=-egy*alfy/(cy11*sqrt(egy*(1+alfy^2)/bety));
cy21=sqrt(egy*(1+alfy^2)/bety)*ry;
cy22=sqrt(egy*(1+alfy^2)/bety)*sqrt(1-ry^2);
%% draw the phase space ellipse from input twiss parameters
xmax=sqrt(eg*bet);
xmin=-xmax;
xvec=linspace(xmax,xmin, 200);
xrev=linspace(xmin,xmax,200); %reverse the order
X=cat(2,xvec,xrev);

ppos=(-alf*xrev+sqrt(bet*eg-xrev.^2))/bet;
pneg=(-alf*xvec-sqrt(bet*eg-xvec.^2))/bet;
P=cat(2,pneg,ppos);

plot(X,P) 
title('Phase space at sequence START, N=2e4');
xlabel('x[m]');
ylabel('x^,');
hold on
%% and also from the estimated parameters
xM1=sqrt(eg1*betx1);
xm1=-xM1;
xv1=linspace(xM1,xm1, 200);
xr1=-xv1;
X1=cat(2,xv1,xr1);

pp1=(-alfx1*xr1+sqrt(betx1*eg1-xr1.^2))/betx1;
pn1=(-alfx1*xv1-sqrt(betx1*eg1-xv1.^2))/betx1;
P1=cat(2,pn1,pp1);
plot(X1,P1);
legend('scatter plot', 'ellipse from input Twiss parameters', 'ellipse from estimated Twiss parameters');

hold off
%% now using the twiss parameter at the END
betf=0.00797;
alff=-0.401;

c11f=sqrt(eg*betf);
c12f=0;
rf=-eg*alff/(c11f*sqrt(eg*(1+alff^2)/betf));
c21f=sqrt(eg*(1+alff^2)/betf)*rf;
c22f=sqrt(eg*(1+alff^2)/betf)*sqrt(1-rf^2);

xf=c11f*x1;
pxf=c21f*x1+c22f*x2;
fig2=scatter(xf,pxf); 
hold on
%now estimate the twiss parameters from the distribution
Sf=cov(xf,pxf);
alfx2=-Sf(1,2)/sqrt(Sf(1,1)*Sf(2,2)-Sf(1,2)^2);
betx2=-alfx2*Sf(1,1)/Sf(1,2);
eg2=Sf(1,1)/betx2;
errbet2=abs(betx2-betf)/betf; %relative error on the estimate 
erreg2=abs(eg2-eg)/eg;
%% draw the ellipse from input parameters
xmaxf=sqrt(eg*betf);
xminf=-xmaxf;
xvecf=linspace(xmaxf,xminf, 200);
xrevf=linspace(xminf,xmaxf,200);
Xf=cat(2,xvecf,xrevf);

pposf=(-alff*xrevf+sqrt(betf*eg-xrevf.^2))/betf;
pnegf=(-alff*xvecf-sqrt(betf*eg-xvecf.^2))/betf;
Pf=cat(2,pnegf,pposf);
plot(Xf,Pf)
hold on
%% and from estimated parameters
xM2=sqrt(eg2*betx2);
xm2=-xM2;
xv2=linspace(xM2,xm2, 200);
xr2=-xv2;
X2=cat(2,xv2,xr2);

pp2=(-alfx2*xr2+sqrt(betx2*eg2-xr2.^2))/betx2;
pn2=(-alfx2*xv2-sqrt(betx2*eg2-xv2.^2))/betx2;
P2=cat(2,pn2,pp2);
plot(X2,P2);
title('Phase space at sequence END, N=2e4');
xlabel('x[m]');
ylabel('x^,');
legend('scatter plot', 'ellipse from input Twiss parameters', 'ellipse from estimated Twiss parameters');
