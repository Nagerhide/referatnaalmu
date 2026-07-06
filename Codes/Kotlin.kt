//Musisz importowac pojedyncze funkcje, a nie cale paczki
import kotlin.math.sqrt
fun main(){
	val dT = 0.001
	val G = 6.67e-11
	val n = readln().toInt()
	var posX = DoubleArray(n)
	var posY = DoubleArray(n)
	var posZ = DoubleArray(n)
	var velX = DoubleArray(n)
	var velY = DoubleArray(n)
	var velZ = DoubleArray(n)
	var mass = DoubleArray(n)
	var dX = DoubleArray(n)
	var dY = DoubleArray(n)
	var dZ = DoubleArray(n)
	var dvX = DoubleArray(n)
	var dvY = DoubleArray(n)
	var dvZ = DoubleArray(n)
	for (i in 0..<n){
		//Jezeli ten kod bedzie prezentowany: tuple w Kotlinie z jakiegos nieznanego powodu maja limit rozmiaru 5 XD
		val values = readln().split(' ').map(String::toDouble)
		posX[i] = values[0]
		posY[i] = values[1]
		posZ[i] = values[2]
		velX[i] = values[3]
		velY[i] = values[4]
		velZ[i] = values[5]
		mass[i] = values[6]
	}
	for (it in 0..<100000){
		for(i in 0..<n){
			dX[i] = 0.0
			dY[i] = 0.0
			dZ[i] = 0.0
			dvX[i] = 0.0
			dvY[i] = 0.0
			dvZ[i] = 0.0
		}
		for(i in 0..<n){
			var WYPX = 0.00
			var WYPY = 0.00
			var WYPZ = 0.00
			for (j in 0..<n){
				if(i == j){
					continue
				}
				val SqDist = (posX[j]-posX[i])*(posX[j]-posX[i])+(posY[j]-posY[i])*(posY[j]-posY[i])+(posZ[j]-posZ[i])*(posZ[j]-posZ[i])
				val Skalar = G * mass[i] * mass[j] / SqDist
				WYPX += Skalar * (posX[j]-posX[i])/sqrt(SqDist)
				WYPY += Skalar * (posY[j]-posY[i])/sqrt(SqDist)
				WYPZ += Skalar * (posZ[j]-posZ[i])/sqrt(SqDist)
			}
			WYPX /= mass[i]
			WYPY /= mass[i]
			WYPZ /= mass[i]
			dX[i] = velX[i] * dT
			dY[i] = velY[i] * dT
			dZ[i] = velZ[i] * dT
			dvX[i] = WYPX * dT
			dvY[i] = WYPY * dT
			dvZ[i] = WYPZ * dT
		}
		for (i in 0..<n){
			velX[i]+=dvX[i]
			velY[i]+=dvY[i]
			velZ[i]+=dvZ[i]
			posX[i]+=dX[i]+0.5*dvX[i]*dT
			posY[i]+=dY[i]+0.5*dvY[i]*dT
			posZ[i]+=dZ[i]+0.5*dvZ[i]*dT
		}
	}
	for (i in 0..<n){
		print(posX[i])
		print(' ')
		print(posY[i])
		print(' ')
		println(posZ[i])
	}
}
