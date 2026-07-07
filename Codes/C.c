#include<stdio.h>
#include<stdlib.h>
#include<math.h>

const double G = 6.67 * 1e-11;
const double dT = 0.001;

int main(int argc, char * argv[]){
	int N;
    	scanf("%d", &N);
	double *POSX, *POSY, *POSZ, *VELX, *VELY, *VELZ, *MASS, *dX, *dY, *dZ, *dvX, *dvY, *dvZ;
	POSX = (double*)malloc(N*sizeof(double));
	POSY = (double*)malloc(N*sizeof(double));
	POSZ = (double*)malloc(N*sizeof(double));
	VELX = (double*)malloc(N*sizeof(double));
	VELY = (double*)malloc(N*sizeof(double));
	VELZ = (double*)malloc(N*sizeof(double));
	MASS = (double*)malloc(N*sizeof(double));
	dX = (double*)malloc(N*sizeof(double));
	dY = (double*)malloc(N*sizeof(double));
	dZ = (double*)malloc(N*sizeof(double));
	dvX = (double*)malloc(N*sizeof(double));
	dvY = (double*)malloc(N*sizeof(double));
	dvZ = (double*)malloc(N*sizeof(double));
	for(int i = 0; i < N; ++i){
		scanf("%Lf %Lf %Lf %Lf %Lf %Lf %Lf", &POSX[i], &POSY[i], &POSZ[i], &VELX[i], &VELY[i], &VELZ[i], &MASS[i]);
	}
	for(int ITERATIONS = 0; ITERATIONS < 100000; ++ITERATIONS){
		for(int k = 0; k < N; ++k){
			dX[k] = 0;
			dY[k] = 0;
			dZ[k] = 0;
			dvX[k] = 0;
			dvY[k] = 0;
			dvZ[k] = 0;
		}
		for(int i = 0; i < N; ++i){
			double WYPX = 0;
			double WYPY = 0;
			double WYPZ = 0;
			for(int j = 0; j < N; ++j){
				if(i == j) continue;
				double sqDIST = (POSX[i]-POSX[j])*(POSX[i]-POSX[j])+(POSY[i]-POSY[j])*(POSY[i]-POSY[j])+(POSZ[i]-POSZ[j])*(POSZ[i]-POSZ[j]);
				double skalar = (G * MASS[i] * MASS[j])/sqDIST;
				double MNOZNIKX = (POSX[j]-POSX[i])/sqrt(sqDIST);
				double MNOZNIKY = (POSY[j]-POSY[i])/sqrt(sqDIST);
				double MNOZNIKZ = (POSZ[j]-POSZ[i])/sqrt(sqDIST);
				WYPX += skalar * MNOZNIKX;
				WYPY += skalar * MNOZNIKY;
				WYPZ += skalar * MNOZNIKZ;
			}
			WYPX/=MASS[i];
			WYPY/=MASS[i];
			WYPZ/=MASS[i];
			dvX[i] = WYPX*dT;
			dvY[i] = WYPY*dT;
			dvZ[i] = WYPZ*dT;
			dX[i] = VELX[i]*dT;
			dY[i] = VELY[i]*dT;
			dZ[i] = VELZ[i]*dT;
		}
		for(int l = 0; l < N; ++l){
			POSX[l]+=dX[l]+0.5*dvX[l]*dT;
			POSY[l]+=dY[l]+0.5*dvY[l]*dT;
			POSZ[l]+=dZ[l]+0.5*dvZ[l]*dT;
			VELX[l]+=dvX[l];
			VELY[l]+=dvY[l];
			VELZ[l]+=dvZ[l];
		}
	}
	for(int i = 0; i < N; ++i){
		printf("%Lf %Lf %Lf \n", POSX[i], POSY[i], POSZ[i]);	
	}
}
