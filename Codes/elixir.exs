defmodule Simulation do
  @g 6.67e-11
  @dt 0.001

  def main do
    data =
      IO.read(:all)
      |> String.split()
      |> Enum.map(&String.to_integer/1)

    [n | values] = data

    posx = :array.new(n, default: 0.0)
    posy = :array.new(n, default: 0.0)
    posz = :array.new(n, default: 0.0)

    velx = :array.new(n, default: 0.0)
    vely = :array.new(n, default: 0.0)
    velz = :array.new(n, default: 0.0)

    mass = :array.new(n, default: 0.0)

    {posx, posy, posz, velx, vely, velz, mass} =
      Enum.reduce(0..(n - 1), 
        {posx, posy, posz, velx, vely, velz, mass},
        fn i, {px, py, pz, vx, vy, vz, m} ->

          index = i * 7

          {
            :array.set(i, Enum.at(values, index) * 1.0, px),
            :array.set(i, Enum.at(values, index + 1) * 1.0, py),
            :array.set(i, Enum.at(values, index + 2) * 1.0, pz),

            :array.set(i, Enum.at(values, index + 3) * 1.0, vx),
            :array.set(i, Enum.at(values, index + 4) * 1.0, vy),
            :array.set(i, Enum.at(values, index + 5) * 1.0, vz),

            :array.set(i, Enum.at(values, index + 6) * 1.0, m)
          }
        end
      )

    simulate(100000, n, posx, posy, posz, velx, vely, velz, mass)
  end


  def simulate(0, n, posx, posy, posz, _velx, _vely, _velz, _mass) do
    Enum.each(0..(n - 1), fn i ->
      IO.puts(
        "#{:array.get(i, posx)} #{:array.get(i, posy)} #{:array.get(i, posz)}"
      )
    end)
  end


  def simulate(iter, n, posx, posy, posz, velx, vely, velz, mass) do

    dvx = :array.new(n, default: 0.0)
    dvy = :array.new(n, default: 0.0)
    dvz = :array.new(n, default: 0.0)

    dx = :array.new(n, default: 0.0)
    dy = :array.new(n, default: 0.0)
    dz = :array.new(n, default: 0.0)


    {dvx, dvy, dvz, dx, dy, dz} =
      Enum.reduce(0..(n - 1),
        {dvx, dvy, dvz, dx, dy, dz},
        fn i, {dvx, dvy, dvz, dx, dy, dz} ->

          {fx, fy, fz} =
            Enum.reduce(0..(n - 1),
              {0.0, 0.0, 0.0},
              fn j, {sx, sy, sz} ->

                if i == j do
                  {sx, sy, sz}
                else
                  rx = :array.get(j, posx) - :array.get(i, posx)
                  ry = :array.get(j, posy) - :array.get(i, posy)
                  rz = :array.get(j, posz) - :array.get(i, posz)

                  dist2 = rx * rx + ry * ry + rz * rz
                  dist = :math.sqrt(dist2)

                  scalar =
                    @g *
                    :array.get(i, mass) *
                    :array.get(j, mass) /
                    dist2

                  {
                    sx + scalar * rx / dist,
                    sy + scalar * ry / dist,
                    sz + scalar * rz / dist
                  }
                end
              end
            )

          {
            :array.set(i, fx / :array.get(i, mass) * @dt, dvx),
            :array.set(i, fy / :array.get(i, mass) * @dt, dvy),
            :array.set(i, fz / :array.get(i, mass) * @dt, dvz),

            :array.set(i, :array.get(i, velx) * @dt, dx),
            :array.set(i, :array.get(i, vely) * @dt, dy),
            :array.set(i, :array.get(i, velz) * @dt, dz)
          }
        end
      )


    posx =
      update_position(posx, dx, dvx, n)

    posy =
      update_position(posy, dy, dvy, n)

    posz =
      update_position(posz, dz, dvz, n)


    velx =
      update_velocity(velx, dvx, n)

    vely =
      update_velocity(vely, dvy, n)

    velz =
      update_velocity(velz, dvz, n)


    simulate(iter - 1, n, posx, posy, posz, velx, vely, velz, mass)
  end


  def update_position(arr, d, dv, n) do
    Enum.reduce(0..(n - 1), arr, fn i, a ->
      :array.set(
        i,
        :array.get(i, a) +
        :array.get(i, d) +
        0.5 * :array.get(i, dv) * @dt,
        a
      )
    end)
  end


  def update_velocity(arr, dv, n) do
    Enum.reduce(0..(n - 1), arr, fn i, a ->
      :array.set(
        i,
        :array.get(i, a) + :array.get(i, dv),
        a
      )
    end)
  end
end

Simulation.main()
