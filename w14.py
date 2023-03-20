import numpy as np
import matplotlib.pyplot as plt
g=7e12/106e6 #gamma factor
G=np.logspace(6,10,num=200) #V/m accelerating gradient
m=106e6*1.78e-36 #muon mass in kg
c=3e8#m/s speed of light
e=1.6e-19#C muon charge
tau=2.2e-6#s muon lifetime
r=np.power(2*g,-m*c/(e*G*tau)) #ratio of survived muons
plt.plot(G,r)
plt.xscale("log")
plt.xlabel('G[V/m]')
plt.ylabel(r'$\frac{N}{N_0}$') 
plt.show()