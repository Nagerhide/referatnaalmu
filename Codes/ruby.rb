G = 6.67e-11
DT = 0.001

n = STDIN.gets.to_i

posx = Array.new(n, 0.0)
posy = Array.new(n, 0.0)
posz = Array.new(n, 0.0)

velx = Array.new(n, 0.0)
vely = Array.new(n, 0.0)
velz = Array.new(n, 0.0)

mass = Array.new(n, 0.0)

dx = Array.new(n, 0.0)
dy = Array.new(n, 0.0)
dz = Array.new(n, 0.0)

dvx = Array.new(n, 0.0)
dvy = Array.new(n, 0.0)
dvz = Array.new(n, 0.0)

(0...n).each do |i|
  a = STDIN.gets.split.map!(&:to_f)

  posx[i] = a[0]
  posy[i] = a[1]
  posz[i] = a[2]

  velx[i] = a[3]
  vely[i] = a[4]
  velz[i] = a[5]

  mass[i] = a[6]
end

100000.times do

  (0...n).each do |i|
    dx[i] = dy[i] = dz[i] = 0.0
    dvx[i] = dvy[i] = dvz[i] = 0.0
  end

  (0...n).each do |i|

    wypx = 0.0
    wypy = 0.0
    wypz = 0.0

    (0...n).each do |j|

      next if i == j

      rx = posx[j] - posx[i]
      ry = posy[j] - posy[i]
      rz = posz[j] - posz[i]

      dist_sq = rx*rx + ry*ry + rz*rz
      dist = Math.sqrt(dist_sq)

      skalar = G * mass[i] * mass[j] / dist_sq

      wypx += skalar * rx / dist
      wypy += skalar * ry / dist
      wypz += skalar * rz / dist
    end

    wypx /= mass[i]
    wypy /= mass[i]
    wypz /= mass[i]

    dvx[i] = wypx * DT
    dvy[i] = wypy * DT
    dvz[i] = wypz * DT

    dx[i] = velx[i] * DT
    dy[i] = vely[i] * DT
    dz[i] = velz[i] * DT
  end

  (0...n).each do |i|
    velx[i] += dvx[i]
    vely[i] += dvy[i]
    velz[i] += dvz[i]

    posx[i] += dx[i] + 0.5 * dvx[i] * DT
    posy[i] += dy[i] + 0.5 * dvy[i] * DT
    posz[i] += dz[i] + 0.5 * dvz[i] * DT
  end
end

(0...n).each do |i|
  printf("%.15f %.15f %.15f\n",
         posx[i],
         posy[i],
         posz[i])
end
