import java.util.ArrayList;
import java.util.Scanner;

public class Java {
	public static void main(String[] args){
		Scanner cin = new Scanner(System.in);
		final double dT = 0.001d;
		final double G = 6.67e-11;
		ArrayList<Double> POSX = new ArrayList<Double>();
		ArrayList<Double> POSY = new ArrayList<Double>();
		ArrayList<Double> POSZ = new ArrayList<Double>();
		ArrayList<Double> VELX = new ArrayList<Double>();
		ArrayList<Double> VELY = new ArrayList<Double>();
		ArrayList<Double> VELZ = new ArrayList<Double>();
		ArrayList<Double> MASS = new ArrayList<Double>();
		ArrayList<Double> dX = new ArrayList<Double>();
		ArrayList<Double> dY = new ArrayList<Double>();
		ArrayList<Double> dZ = new ArrayList<Double>();
		ArrayList<Double> dvX = new ArrayList<Double>();
		ArrayList<Double> dvY = new ArrayList<Double>();
		ArrayList<Double> dvZ = new ArrayList<Double>();
		int n = cin.nextInt();
		for (int i = 0; i < n; ++i){
			POSX.add(cin.nextDouble());
			POSY.add(cin.nextDouble());
			POSZ.add(cin.nextDouble());
			VELX.add(cin.nextDouble());
			VELY.add(cin.nextDouble());
			VELZ.add(cin.nextDouble());
			MASS.add(cin.nextDouble());
			dX.add(0.0);
			dY.add(0.0);
			dZ.add(0.0);
			dvX.add(0.0);
			dvY.add(0.0);
			dvZ.add(0.0);
		}
		for(int IT = 0; IT < 100000; ++IT){
			for(int i = 0; i < n; ++i){
				dX.set(i, 0.0);
				dY.set(i, 0.0);
				dZ.set(i, 0.0);
				dvX.set(i, 0.0);
				dvY.set(i, 0.0);
				dvZ.set(i, 0.0);
			}
			for(int i = 0; i < n; ++i){
				double WYPX = 0.00;
				double WYPY = 0.00;
				double WYPZ = 0.00;
				for(int j = 0; j < n; ++j){
					if(i == j){
						continue;
					}
					double distsq = (POSX.get(j)-POSX.get(i))*(POSX.get(j)-POSX.get(i))+(POSY.get(j)-POSY.get(i))*(POSY.get(j)-POSY.get(i))+(POSZ.get(j)-POSZ.get(i))*(POSZ.get(j)-POSZ.get(i));
					double Skalar = G * MASS.get(i) * MASS.get(j) / distsq;
					WYPX += Skalar * (POSX.get(j)-POSX.get(i))/Math.sqrt(distsq);
					WYPY += Skalar * (POSY.get(j)-POSY.get(i))/Math.sqrt(distsq);
					WYPZ += Skalar * (POSZ.get(j)-POSZ.get(i))/Math.sqrt(distsq);
				}
				WYPX /= MASS.get(i);
				WYPY /= MASS.get(i);
				WYPZ /= MASS.get(i);
				dvX.set(i, WYPX*dT);
				dvY.set(i, WYPY*dT);
				dvZ.set(i, WYPZ*dT);
				dX.set(i, VELX.get(i)*dT);
				dY.set(i, VELY.get(i)*dT);
				dZ.set(i, VELZ.get(i)*dT);
			}
			for(int i = 0; i < n; ++i){
				VELX.set(i, VELX.get(i)+dvX.get(i));
				VELY.set(i, VELY.get(i)+dvY.get(i));
				VELZ.set(i, VELZ.get(i)+dvZ.get(i));
				POSX.set(i, POSX.get(i)+dX.get(i)+0.5*dvX.get(i)*dT);
				POSY.set(i, POSY.get(i)+dY.get(i)+0.5*dvY.get(i)*dT);
				POSZ.set(i, POSZ.get(i)+dZ.get(i)+0.5*dvZ.get(i)*dT);
			}
			
		}
		for(int i = 0; i < n; ++i){
			System.out.print(POSX.get(i));
			System.out.print(" ");
			System.out.print(POSY.get(i));
			System.out.print(" ");
			System.out.println(POSZ.get(i));
		}
	}
}
