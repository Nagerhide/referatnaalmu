package main
import ("fmt"; "math")

func main(){
	var N int
	fmt.Scan(&N)
	var POSX []float64
	var POSY []float64
	var POSZ []float64	
	var VELX []float64
	var VELY []float64
	var VELZ []float64
	var MASS []float64
	var dX []float64
	var dY []float64
	var dZ []float64
	var dvX []float64
	var dvY []float64
	var dvZ []float64
	var dT float64
	dT = 0.001
	var G float64
	G = 6.67 * 1e-11
	for i := 0; i < N; i++ {
		var A, B, C, D, E, F, G float64
		fmt.Scan(&A, &B, &C, &D, &E, &F, &G)
		POSX = append(POSX, A)
		POSY = append(POSY, B)
		POSZ = append(POSZ, C)
		VELX = append(VELX, D)
		VELY = append(VELY, E)
		VELZ = append(VELZ, F)
		MASS = append(MASS, G)
		dX = append(dX, 0.00)
		dY = append(dY, 0.00)
		dZ = append(dZ, 0.00)
		dvX = append(dvX, 0.00)
		dvY = append(dvY, 0.00)
		dvZ = append(dvZ, 0.00)
	}
	
	for IT := 0; IT < 100000; IT++ {
		for i:= 0; i < N; i++{
			dX[i]=0.00
			dY[i]=0.00
			dZ[i]=0.00
			dvX[i]=0.00
			dvY[i]=0.00
			dvZ[i]=0.00
		}
		for i:= 0; i < N; i++{
			var WYPX float64
			var WYPY float64
			var WYPZ float64
			for j:= 0; j < N; j++{
				if i == j {
					continue
				}
				var Skalar float64
				var Distsq float64
				Distsq = (POSX[j]-POSX[i])*(POSX[j]-POSX[i])+(POSY[j]-POSY[i])*(POSY[j]-POSY[i])+(POSZ[j]-POSZ[i])
				Skalar = G * MASS[i] * MASS[j] / Distsq
				WYPX+= Skalar * (POSX[j]-POSX[i])/math.Sqrt(Distsq)
				WYPY+= Skalar * (POSY[j]-POSY[i])/math.Sqrt(Distsq)
				WYPZ+= Skalar * (POSZ[j]-POSZ[i])/math.Sqrt(Distsq)
			}
			WYPX /= MASS[i]
			WYPY /= MASS[i]
			WYPZ /= MASS[i]
			dvX[i] = WYPX*dT
			dvY[i] = WYPY*dT
			dvZ[i] = WYPZ*dT
			dX[i] = VELX[i]*dT
			dY[i] = VELY[i]*dT
			dZ[i] = VELZ[i]*dT

		}
		for i := 0; i < N; i++{
			VELX[i] += dvX[i]
			VELY[i] += dvY[i]
			VELZ[i] += dvZ[i]
			POSX[i] += dX[i] + 0.5*dT*dvX[i]
			POSY[i] += dY[i] + 0.5*dT*dvY[i]
			POSZ[i] += dZ[i] + 0.5*dT*dvZ[i]
		}
	}
	for i := 0; i < N; i++{
		fmt.Println(POSX[i], " ", POSY[i], " ", POSZ[i])
	}
}
