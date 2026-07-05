#include<stdio.h>
#include<stdlib.h>
#include<math.h>

const long double G = 6.67 * 1e-11;
const long double dT = 0.001;

int main(int argc, char * argv[]){
	if(argc == 1){
		printf("File direction not specified. Terminating program.\n");
		return 0;
	}
	freopen(argv[1], "r", stdin);
	if(argc == 2){
		printf("Output not specified, defaulted to stdout.\n");
	}
	else{
		freopen(argv[2], "w", stdout);	
	}
	int N;
       	scanf("%d", &N);
	long double* POSX;
	long double* POSY;
	long double* POSZ;
	long double* VELX;
	long double* VELY;
	long double* VELZ;
	long double* MASS;
	long double* dX;
	long double* dY;
	long double* dZ;
	long double* dvX;
	long double* dvY;
	long double* dvZ;
	POSX = (long double*)malloc(N*sizeof(long double));
	POSY = (long double*)malloc(N*sizeof(long double));
	POSZ = (long double*)malloc(N*sizeof(long double));
	VELX = (long double*)malloc(N*sizeof(long double));
	VELY = (long double*)malloc(N*sizeof(long double));
	VELZ = (long double*)malloc(N*sizeof(long double));
	MASS = (long double*)malloc(N*sizeof(long double));
	dX = (long double*)malloc(N*sizeof(long double));
	dY = (long double*)malloc(N*sizeof(long double));
	dZ = (long double*)malloc(N*sizeof(long double));
	dvX = (long double*)malloc(N*sizeof(long double));
	dvY = (long double*)malloc(N*sizeof(long double));
	dvZ = (long double*)malloc(N*sizeof(long double));
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
			long double WYPX = 0;
			long double WYPY = 0;
			long double WYPZ = 0;
			for(int j = 0; j < N; ++j){
				if(i == j) continue;
				long double sqDIST = (POSX[i]-POSX[j])*(POSX[i]-POSX[j])+(POSY[i]-POSY[j])*(POSY[i]-POSY[j])+(POSZ[i]-POSZ[j])*(POSZ[i]-POSZ[j]);
				long double skalar = (G * MASS[i] * MASS[j])/sqDIST;
				long double MNOZNIKX = (POSX[j]-POSX[i])/sqrtl(sqDIST);
				long double MNOZNIKY = (POSY[j]-POSY[i])/sqrtl(sqDIST);
				long double MNOZNIKZ = (POSZ[j]-POSZ[i])/sqrtl(sqDIST);
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
		printf("%Lf %Lf %Lf", POSX[i], POSY[i], POSZ[i]);	
	}
}
