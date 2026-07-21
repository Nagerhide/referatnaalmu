G <- 6.67e-11
dT <- 0.001

N <- as.integer(readLines("stdin", n = 1))

POSX <- numeric(N)
POSY <- numeric(N)
POSZ <- numeric(N)

VELX <- numeric(N)
VELY <- numeric(N)
VELZ <- numeric(N)

MASS <- numeric(N)

dX <- numeric(N)
dY <- numeric(N)
dZ <- numeric(N)

dvX <- numeric(N)
dvY <- numeric(N)
dvZ <- numeric(N)

for (i in 1:N) {
    a <- as.numeric(strsplit(trimws(readLines("stdin", n = 1)), "\\s+")[[1]])

    POSX[i] <- a[1]
    POSY[i] <- a[2]
    POSZ[i] <- a[3]

    VELX[i] <- a[4]
    VELY[i] <- a[5]
    VELZ[i] <- a[6]

    MASS[i] <- a[7]
}

for (it in 1:100000) {

    dX[] <- 0
    dY[] <- 0
    dZ[] <- 0

    dvX[] <- 0
    dvY[] <- 0
    dvZ[] <- 0

    for (i in 1:N) {

        WYPX <- 0
        WYPY <- 0
        WYPZ <- 0

        for (j in 1:N) {

            if (i == j)
                next

            dx <- POSX[j] - POSX[i]
            dy <- POSY[j] - POSY[i]
            dz <- POSZ[j] - POSZ[i]

            distSq <- dx*dx + dy*dy + dz*dz
            dist <- sqrt(distSq)

            skalar <- G * MASS[i] * MASS[j] / distSq

            WYPX <- WYPX + skalar * dx / dist
            WYPY <- WYPY + skalar * dy / dist
            WYPZ <- WYPZ + skalar * dz / dist
        }

        WYPX <- WYPX / MASS[i]
        WYPY <- WYPY / MASS[i]
        WYPZ <- WYPZ / MASS[i]

        dvX[i] <- WYPX * dT
        dvY[i] <- WYPY * dT
        dvZ[i] <- WYPZ * dT

        dX[i] <- VELX[i] * dT
        dY[i] <- VELY[i] * dT
        dZ[i] <- VELZ[i] * dT
    }

    for (i in 1:N) {

        VELX[i] <- VELX[i] + dvX[i]
        VELY[i] <- VELY[i] + dvY[i]
        VELZ[i] <- VELZ[i] + dvZ[i]

        POSX[i] <- POSX[i] + dX[i] + 0.5 * dvX[i] * dT
        POSY[i] <- POSY[i] + dY[i] + 0.5 * dvY[i] * dT
        POSZ[i] <- POSZ[i] + dZ[i] + 0.5 * dvZ[i] * dT
    }
}

for (i in 1:N) {
    cat(sprintf("%.15f %.15f %.15f\n",
        POSX[i], POSY[i], POSZ[i]))
}
