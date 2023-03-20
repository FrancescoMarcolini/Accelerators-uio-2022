from wsgiref.headers import tspecials
from madxtools.tablefs import TableFS
import matplotlib.pyplot as plt
import numpy as np

# Load data
tfsObj = TableFS("trackingint.tfsone")
tfsObj.convertToNumpy()
print("Done")
print()
#analisis of the distribution at START
S=np.cov(tfsObj.Data["X"][1:19999], tfsObj.Data["PX"][1:19999])
alfx1=-S[0][1]/np.sqrt(S[0][0]*S[1][1]-np.power(S[0][1],2))
betx1=-alfx1*S[0][0]/S[0][1]
eg1=S[0][0]/betx1


# plot data at START
plt.scatter(tfsObj.Data["X"][2000:9000], tfsObj.Data["PX"][2000:9000])
plt.title("Phase space at START of the sequence")
plt.xlabel("x[m]")
plt.ylabel("x'")

# draw the ellipse from distribution at START
xM=np.sqrt(eg1*betx1)
xm=-xM
xvec=np.linspace(xM,xm, 200)

ppos=(-alfx1*xvec+np.sqrt(betx1*eg1-np.power(xvec,2)))/betx1
pneg=(-alfx1*xvec-np.sqrt(betx1*eg1-np.power(xvec,2)))/betx1
plt.plot(xvec,ppos, color='r')
plt.plot(xvec,pneg, color='r')

plt.show()
#analisis of the distribution at END
Z=np.cov(tfsObj.Data["X"][20001:39999], tfsObj.Data["PX"][20001:39999])
alfx2=-Z[0][1]/np.sqrt(Z[0][0]*Z[1][1]-np.power(Z[0][1],2))
betx2=-alfx2*Z[0][0]/Z[0][1]
eg2=Z[0][0]/betx2
# draw the ellipse from distribution at END
xM2=np.sqrt(eg2*betx2)
xm2=-xM2
xvec2=np.linspace(xM2,xm2, 200)

ppos2=(-alfx2*xvec2+np.sqrt(betx2*eg2-np.power(xvec2,2)))/betx2
pneg2=(-alfx2*xvec2-np.sqrt(betx2*eg2-np.power(xvec2,2)))/betx2
plt.plot(xvec2,ppos2, color='r')
plt.plot(xvec2,pneg2, color='r')


# plot data at END
plt.scatter(tfsObj.Data["X"][22000:29000], tfsObj.Data["PX"][22000:29000])
plt.title("Phase space at END of the sequence")
plt.xlabel("x[m]")
plt.ylabel("x'")

plt.show()

size2=np.sqrt(betx2*eg2)
print('size=', size2)