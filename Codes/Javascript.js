const fs = require("fs");

const input = fs.readFileSync(0, "utf8").trim().split(/\s+/);

let ptr = 0;

const G = 6.67e-11;
const dT = 0.001;
const N = Number(input[ptr++]);
const POSX = new Array(N);
const POSY = new Array(N);
const POSZ = new Array(N);
const VELX = new Array(N);
const VELY = new Array(N);
const VELZ = new Array(N);
const MASS = new Array(N);
const dX = new Array(N).fill(0);
const dY = new Array(N).fill(0);
const dZ = new Array(N).fill(0);
const dvX = new Array(N).fill(0);
const dvY = new Array(N).fill(0);
const dvZ = new Array(N).fill(0);

for (let i = 0; i < N; i++) {
    POSX[i] = Number(input[ptr++]);
    POSY[i] = Number(input[ptr++]);
    POSZ[i] = Number(input[ptr++]);
    VELX[i] = Number(input[ptr++]);
    VELY[i] = Number(input[ptr++]);
    VELZ[i] = Number(input[ptr++]);
    MASS[i] = Number(input[ptr++]);
}

for (let iteration = 0; iteration < 100000; iteration++) {
    for (let k = 0; k < N; k++) {
        dX[k] = dY[k] = dZ[k] = 0;
        dvX[k] = dvY[k] = dvZ[k] = 0;
    }
    for (let i = 0; i < N; i++) {

        let WYPX = 0;
        let WYPY = 0;
        let WYPZ = 0;
        for (let j = 0; j < N; j++) {

            if (i === j) continue;
            const sqDIST = (POSX[j]-POSX[i]) * (POSX[j]-POSX[i])+(POSY[j]-POSY[i])*((POSY[j]-POSY[i]))+(POSZ[j]-POSZ[i])*((POSZ[j]-POSZ[i]));
            const force = (G * MASS[i] * MASS[j]) / sqDIST;
            WYPX += force*(POSX[j]-POSX[i])/Math.sqrt(sqDIST);
            WYPY += force*(POSY[j]-POSY[i])/Math.sqrt(sqDIST);
            WYPZ += force*(POSZ[j]-POSZ[i])/Math.sqrt(sqDIST);
        }
        WYPX /= MASS[i];
        WYPY /= MASS[i];
        WYPZ /= MASS[i];
        dvX[i] = WYPX*dT;
        dvY[i] = WYPY*dT;
        dvZ[i] = WYPZ*dT;
        dX[i] = VELX[i]*dT;
        dY[i] = VELY[i]*dT;
        dZ[i] = VELZ[i]*dT;
    }
    for (let i = 0; i < N; i++) {
        POSX[i] += dX[i] + 0.5*dvX[i]*dT;
        POSY[i] += dY[i] + 0.5*dvY[i]*dT;
        POSZ[i] += dZ[i] + 0.5*dvZ[i]*dT;
        VELX[i] += dvX[i];
        VELY[i] += dvY[i];
        VELZ[i] += dvZ[i];
    }
}
for (let i = 0; i < N; i++) {
    console.log(POSX[i], POSY[i], POSZ[i]);
}