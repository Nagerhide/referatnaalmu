import Foundation

let G = 6.67e-11
let dT = 0.001

var POSX = Array(repeating: 0.0, count: N)
var POSY = Array(repeating: 0.0, count: N)
var POSZ = Array(repeating: 0.0, count: N)
var VELX = Array(repeating: 0.0, count: N)
var VELY = Array(repeating: 0.0, count: N)
var VELZ = Array(repeating: 0.0, count: N)
var MASS = Array(repeating: 0.0, count: N)
var dX = Array(repeating: 0.0, count: N)
var dY = Array(repeating: 0.0, count: N)
var dZ = Array(repeating: 0.0, count: N)
var dvX = Array(repeating: 0.0, count: N)
var dvY = Array(repeating: 0.0, count: N)
var dvZ = Array(repeating: 0.0, count: N)

for i in 0..<N {
    let values = readLine()!.split(separator: " ").map { Double($0)! }
    POSX[i] = values[0]
    POSY[i] = values[1]
    POSZ[i] = values[2]
    VELX[i] = values[3]
    VELY[i] = values[4]
    VELZ[i] = values[5]
    MASS[i] = values[6]
}
for ITERATIONS in 0..<100000 {
    for k in 0..<N {
        dX[k] = 0
        dY[k] = 0
        dZ[k] = 0
        dvX[k] = 0
        dvY[k] = 0
        dvZ[k] = 0
    }
    for i in 0..<N {
        var WYPX = 0.0
        var WYPY = 0.0
        var WYPZ = 0.0
        for j in 0..<N {
            if i == j {
                continue
            }
            let sqDIST = (POSX[i]-POSX[j])*(POSX[i]-POSX[j])+(POSY[i]-POSY[j])*(POSY[i]-POSY[j])+(POSZ[i]-POSZ[j])*(POSZ[i]-POSZ[j])
            let skalar = (G*MASS[i]*MASS[j])/sqDIST
            let MNOZNIKX = (POSX[j]-POSX[i]) / sqrt(sqDIST)
            let MNOZNIKY = (POSY[j]-POSY[i]) / sqrt(sqDIST)
            let MNOZNIKZ = (POSZ[j]-POSZ[i]) / sqrt(sqDIST)
            WYPX += skalar * MNOZNIKX
            WYPY += skalar * MNOZNIKY
            WYPZ += skalar * MNOZNIKZ
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
    for l in 0..<N {
        POSX[l] += dX[l] + 0.5*dvX[l]*dT
        POSY[l] += dY[l] + 0.5*dvY[l]*dT
        POSZ[l] += dZ[l] + 0.5*dvZ[l]*dT
        VELX[l] += dvX[l]
        VELY[l] += dvY[l]
        VELZ[l] += dvZ[l]
    }
}

for i in 0..<N {
    print(POSX[i], POSY[i], POSZ[i])
}