import 'dart:io';
import 'dart:math';

void main(){
    int N = int.parse(stdin.readLineSync()!);
    const double dT = 0.001;
    const double G = 6.67e-11;
    List<double> POSX = List.filled(N, 0.0);
    List<double> POSY = List.filled(N, 0.0);
    List<double> POSZ = List.filled(N, 0.0);
    List<double> VELX = List.filled(N, 0.0);
    List<double> VELY = List.filled(N, 0.0);
    List<double> VELZ = List.filled(N, 0.0);
    List<double> MASS = List.filled(N, 0.0);
    List<double> dX = List.filled(N, 0.0);
    List<double> dY = List.filled(N, 0.0);
    List<double> dZ = List.filled(N, 0.0);
    List<double> dvX = List.filled(N, 0.0);
    List<double> dvY = List.filled(N, 0.0);
    List<double> dvZ = List.filled(N, 0.0);
    for(int i = 0; i < N; ++i){
        List<double> numbers = stdin.readLineSync()!.split(' ').map(double.parse).toList();
        POSX[i] = numbers[0];
        POSY[i] = numbers[1];
        POSZ[i] = numbers[2];
        VELX[i] = numbers[3];
        VELY[i] = numbers[4];
        VELZ[i] = numbers[5];
        MASS[i] = numbers[6];
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
    for(int l = 0; l < N; ++l){
		print("${POSX[l]} ${POSY[l]} ${POSZ[l]}");
	}
}