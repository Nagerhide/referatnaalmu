const G = 6.67e-11
const dT = 0.001

N = parse(Int, readline())

POSX = zeros(Float64, N)
POSY = zeros(Float64, N)
POSZ = zeros(Float64, N)

VELX = zeros(Float64, N)
VELY = zeros(Float64, N)
VELZ = zeros(Float64, N)

MASS = zeros(Float64, N)

dX = zeros(Float64, N)
dY = zeros(Float64, N)
dZ = zeros(Float64, N)

dvX = zeros(Float64, N)
dvY = zeros(Float64, N)
dvZ = zeros(Float64, N)

for i in 1:N
    a = parse.(Float64, split(readline()))

    POSX[i] = a[1]
    POSY[i] = a[2]
    POSZ[i] = a[3]

    VELX[i] = a[4]
    VELY[i] = a[5]
    VELZ[i] = a[6]

    MASS[i] = a[7]
end

for it in 1:100000

    fill!(dX, 0.0)
    fill!(dY, 0.0)
    fill!(dZ, 0.0)

    fill!(dvX, 0.0)
    fill!(dvY, 0.0)
    fill!(dvZ, 0.0)

    for i in 1:N

        WYPX = 0.0
        WYPY = 0.0
        WYPZ = 0.0

        for j in 1:N

            if i == j
                continue
            end

            dx = POSX[j] - POSX[i]
            dy = POSY[j] - POSY[i]
            dz = POSZ[j] - POSZ[i]

            distSq = dx*dx + dy*dy + dz*dz
            dist = sqrt(distSq)

            skalar = G * MASS[i] * MASS[j] / distSq

            WYPX += skalar * dx / dist
            WYPY += skalar * dy / dist
            WYPZ += skalar * dz / dist
        end

        WYPX /= MASS[i]
        WYPY /= MASS[i]
        WYPZ /= MASS[i]

        dvX[i] = WYPX * dT
        dvY[i] = WYPY * dT
        dvZ[i] = WYPZ * dT

        dX[i] = VELX[i] * dT
        dY[i] = VELY[i] * dT
        dZ[i] = VELZ[i] * dT
    end

    for i in 1:N

        VELX[i] += dvX[i]
        VELY[i] += dvY[i]
        VELZ[i] += dvZ[i]

        POSX[i] += dX[i] + 0.5 * dvX[i] * dT
        POSY[i] += dY[i] + 0.5 * dvY[i] * dT
        POSZ[i] += dZ[i] + 0.5 * dvZ[i] * dT
    end
end

for i in 1:N
    println(POSX[i], " ", POSY[i], " ", POSZ[i])
end
