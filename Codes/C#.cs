using System;
using System.Linq;
using System.Collections.Generic;

public class PROGRAM {
	static public void Main(){
		int N = Convert.ToInt32(Console.ReadLine());
		const double dT = 0.001;
		const double G = 6.67e-11;
		double[] POSX = new double[N];
		double[] POSY = new double[N];
		double[] POSZ = new double[N];
		double[] VELX = new double[N];
		double[] VELY = new double[N];
		double[] VELZ = new double[N];
		double[] MASS = new double[N];
		double[] dX = new double[N];
		double[] dY = new double[N];
		double[] dZ = new double[N];
		double[] dvX = new double[N];
		double[] dvY = new double[N];
		double[] dvZ = new double[N];
		for (int i = 0; i < N; ++i){
			string[] parts = Console.ReadLine().Split(' ');
			POSX[i] = double.Parse(parts[0]);
			POSY[i] = double.Parse(parts[1]);
			POSZ[i] = double.Parse(parts[2]);
			VELX[i] = double.Parse(parts[3]);
			VELY[i] = double.Parse(parts[4]);
			VELZ[i] = double.Parse(parts[5]);
			MASS[i] = double.Parse(parts[6]);
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
				double MNOZNIKX = (POSX[j]-POSX[i])/Math.Sqrt(sqDIST);
				double MNOZNIKY = (POSY[j]-POSY[i])/Math.Sqrt(sqDIST);
				double MNOZNIKZ = (POSZ[j]-POSZ[i])/Math.Sqrt(sqDIST);
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
		Console.WriteLine("{0} {1} {2}", POSX[i], POSY[i], POSZ[i]);
	}
	}
}
