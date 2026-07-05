//https://doc.rust-lang.org/book/title-page.html
use std::io;

const G: f64 = 6.67 * 1e-11;
const dT: f64 = 0.001;

fn main(){
    
    let mut Inputstring = String::new();
    io::stdin().read_line(&mut Inputstring);
    let n: u32 = Inputstring.trim().parse().expect("cos");
    let mut POSX = vec![0.00f64];
    let mut POSY = vec![0.00f64];
    let mut POSZ = vec![0.00f64];
    let mut VELX = vec![0.00f64];
    let mut VELY = vec![0.00f64];
    let mut VELZ = vec![0.00f64];
    let mut MASS = vec![0.00f64];
    let mut dX = vec![0.00f64];
    let mut dY = vec![0.00f64];
    let mut dZ = vec![0.00f64];
    let mut dvX = vec![0.00f64];
    let mut dvY = vec![0.00f64];
    let mut dvZ = vec![0.00f64];

    POSX.resize(n as usize, 0.00);
    POSY.resize(n as usize, 0.00);
    POSZ.resize(n as usize, 0.00);
    VELX.resize(n as usize, 0.00);
    VELY.resize(n as usize, 0.00);
    VELZ.resize(n as usize, 0.00);
    MASS.resize(n as usize, 0.00);
    dX.resize(n as usize, 0.00);
    dY.resize(n as usize, 0.00);
    dZ.resize(n as usize, 0.00);
    dvX.resize(n as usize, 0.00);
    dvY.resize(n as usize, 0.00);
    dvZ.resize(n as usize, 0.00);

    for i in 0..n {
        Inputstring.clear();
        io::stdin().read_line(&mut Inputstring);
        let X: Vec<f64> = Inputstring.trim().split(' ').map(|Inputstring| Inputstring.parse().unwrap()).collect();
        let [a, b, c, d, e, f, g] = *X else{ panic!() };
        POSX[i as usize]=a;
        POSY[i as usize]=b;
        POSZ[i as usize]=c;
        VELX[i as usize]=d;
        VELY[i as usize]=e;
        VELZ[i as usize]=f;
        MASS[i as usize]=g;
    }
    for ITERATIONS in 0..100000{
        for i in 0.. n{
            dX[i as usize] = 0.00;
            dY[i as usize] = 0.00;
            dZ[i as usize] = 0.00;
            dvX[i as usize] = 0.00;
            dvY[i as usize] = 0.00;
            dvZ[i as usize] = 0.00;
        }
        for i in 0..n{
            let mut WYPX: f64 = 0.00;
            let mut WYPY: f64 = 0.00;
            let mut WYPZ: f64 = 0.00;
            for j in 0..n{
                if (i == j){
                    continue;
                }
                let Distsq: f64 = (POSX[j as usize]-POSX[i as usize])*(POSX[j as usize]-POSX[i as usize])+(POSY[j as usize]-POSY[i as usize])*(POSY[j as usize]-POSY[i as usize])+(POSZ[j as usize]-POSZ[i as usize])*(POSZ[j as usize]-POSZ[i as usize]);
                let Skalar: f64 = (G * MASS[i as usize] * MASS[j as usize])/Distsq;
                WYPX += Skalar * (POSX[j as usize]-POSX[i as usize])/Distsq.sqrt();
                WYPY += Skalar * (POSY[j as usize]-POSY[j as usize])/Distsq.sqrt();
                WYPZ += Skalar * (POSZ[j as usize]-POSZ[j as usize])/Distsq.sqrt();
            }
            WYPX /= MASS[i as usize];
            WYPY /= MASS[i as usize];
            WYPZ /= MASS[i as usize];
            dvX[i as usize] = WYPX * dT;
            dvY[i as usize] = WYPY * dT;
            dvZ[i as usize] = WYPZ * dT;
            dX[i as usize] = VELX[i as usize] * dT;
            dY[i as usize] = VELY[i as usize] * dT;
            dZ[i as usize] = VELZ[i as usize] * dT;
        }
        for j in 0..n{
            VELX[j as usize] += dvX[j as usize];
            VELY[j as usize] += dvY[j as usize];
            VELZ[j as usize] += dvZ[j as usize];
            POSX[j as usize] += dX[j as usize] + 0.5*dvX[j as usize]*dT;
            POSY[j as usize] += dY[j as usize] + 0.5*dvY[j as usize]*dT;
            POSZ[j as usize] += dZ[j as usize] + 0.5*dvZ[j as usize]*dT;
        }

    }
    for i in 0..n{
        println!("{} {} {}", POSX[i as usize], POSY[i as usize], POSZ[i as usize]);
    }
}
