

dT = 0.001
G = 6.67e-11
POSX = {}
POSY = {}
POSZ = {}
VELX = {}
VELY = {}
VELZ = {}
MASS = {}
dX = {}
dY = {}
dZ = {}
dvX = {}
dvY = {}
dvZ = {}

n = io.read("*n")
for i = 1,n do
	POSX[i] = io.read("*n")
	POSY[i] = io.read("*n")
	POSZ[i] = io.read("*n")
	VELX[i] = io.read("*n")
	VELY[i] = io.read("*n")
	VELZ[i] = io.read("*n")
	MASS[i] = io.read("*n")
end

for it = 1,100000 do
	for i =1,n do
		dX[i]=0
		dY[i]=0
		dZ[i]=0
		dvX[i]=0
		dvY[i]=0
		dvZ[i]=0
	end
	for i =1,n do
		WYPX = 0
		WYPY = 0
		WYPZ = 0
		for j =1,n do
			if i ~= j then
				
			distsq = (POSX[j]-POSX[i])*(POSX[j]-POSX[i])+(POSY[j]-POSY[i])*(POSY[j]-POSY[i])+(POSZ[j]-POSZ[i])*(POSZ[j]-POSZ[i])
			Skalar = G*MASS[i]*MASS[j] / distsq
			WYPX = WYPX+Skalar * (POSX[j]-POSX[i])/math.sqrt(distsq)
			WYPY = WYPY+Skalar * (POSY[j]-POSY[i])/math.sqrt(distsq)
			WYPZ = WYPZ+Skalar * (POSZ[j]-POSZ[i])/math.sqrt(distsq)
			end
		end
		WYPX = WYPX / MASS[i]
		WYPY = WYPY / MASS[i]
		WYPZ = WYPZ / MASS[i]
		dvX[i]=WYPX*dT
		dvY[i]=WYPY*dT
		dvZ[i]=WYPZ*dT
		dX[i]=VELX[i]*dT
		dY[i]=VELY[i]*dT
		dZ[i]=VELZ[i]*dT
	end
	for i = 1,n do
		VELX[i] = VELX[i]+dvX[i];
		VELY[i] = VELY[i]+dvY[i];
		VELZ[i] = VELZ[i]+dvZ[i];
		POSX[i] = POSX[i]+dX[i]+0.5*dT*dvX[i]
		POSY[i] = POSY[i]+dY[i]+0.5*dT*dvY[i]
		POSZ[i] = POSZ[i]+dZ[i]+0.5*dT*dvZ[i]
	end
end
for i = 1,n do
	print(POSX[i], " ", POSY[i], " ", POSZ[i])
end
