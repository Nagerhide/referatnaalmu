import sys
import math


G = 6.67*1e-11
dT = 0.001
if(len(sys.argv) == 1):
    print("No input file specified. Terminating program.")
    exit()

cin = open(sys.argv[1], "r")
if(len(sys.argv) == 3):
    cout = open(sys.argv[2], "w")

N = int(cin.readline())
VelX, VelY, VelZ, PosX, PosY, PosZ, Mass, dvX, dvY, dvZ, dX, dY, dZ = (
    [], [], [], [], [], [], [], [], [], [], [], [], []
)
for i in range(N):
    A, B, C, D, E, F, H = map(float, cin.readline().split())
    PosX.append(A)
    PosY.append(B)
    PosZ.append(C)
    VelX.append(D)
    VelY.append(E)
    VelZ.append(F)
    Mass.append(H)
    dvX.append(0.00)
    dvY.append(0.00)
    dvZ.append(0.00)
    dX.append(0.00)
    dY.append(0.00)
    dZ.append(0.00)

for ITERATIONS in range(100000):
    for i in range(N):
        dvX[i] = 0.0
        dvY[i] = 0.0
        dvZ[i] = 0.0
        dX[i] = 0.0
        dY[i] = 0.0
        dZ[i] = 0.0
    for i in range(N):
        FwypX = 0.00
        FwypY = 0.00
        FwypZ = 0.00
        for j in range(N):
            if i == j:
                continue
            Stala = (G * Mass[i]* Mass[j])/((PosX[i]-PosX[j])**2+(PosY[i]-PosY[j])**2+(PosZ[i]-PosZ[j])**2)
            Dist = math.sqrt((PosX[i]-PosX[j])**2+(PosY[i]-PosY[j])**2+(PosZ[i]-PosZ[j])**2)
            FwypX += (PosX[j]-PosX[i])/Dist * Stala
            FwypY += (PosY[j]-PosY[i])/Dist * Stala
            FwypZ += (PosZ[j]-PosZ[i])/Dist * Stala
        FwypX /= Mass[i]
        FwypY /= Mass[i]
        FwypZ /= Mass[i]
        dvX[i] = FwypX * dT
        dvY[i] = FwypY * dT
        dvZ[i] = FwypZ * dT
        dX[i] = VelX[i] * dT
        dY[i] = VelY[i] * dT
        dZ[i] = VelZ[i] * dT
    
    for i in range(N):
        VelX[i]+=dvX[i]
        VelY[i]+=dvY[i]
        VelZ[i]+=dvZ[i]
        PosX[i]+=dX[i]+0.5 * dvX[i] * dT
        PosY[i]+=dY[i]+0.5 * dvY[i] * dT
        PosZ[i]+=dZ[i]+0.5 * dvZ[i] * dT

if len(sys.argv) == 3:
    for j in range(N):
        cout.write(PosX[j])
        cout.write(" ")
        cout.write(PosY[j])
        cout.write(" ")
        cout.write(POSZ[j])
        cout.write("\n")
else:
    for j in range(N):
        print(PosX[j], " ", PosY[j], " ", PosZ[j])
