import scala.io.StdIn

object Scala {

  val G = 6.67e-11
  val dT = 0.001

  def main(args: Array[String]): Unit = {

    val N = StdIn.readInt()

    val POSX = Array.ofDim[Double](N)
    val POSY = Array.ofDim[Double](N)
    val POSZ = Array.ofDim[Double](N)

    val VELX = Array.ofDim[Double](N)
    val VELY = Array.ofDim[Double](N)
    val VELZ = Array.ofDim[Double](N)

    val MASS = Array.ofDim[Double](N)

    val dX = Array.ofDim[Double](N)
    val dY = Array.ofDim[Double](N)
    val dZ = Array.ofDim[Double](N)

    val dvX = Array.ofDim[Double](N)
    val dvY = Array.ofDim[Double](N)
    val dvZ = Array.ofDim[Double](N)

    for (i <- 0 until N) {
      val a = StdIn.readLine().split("\\s+").map(_.toDouble)

      POSX(i) = a(0)
      POSY(i) = a(1)
      POSZ(i) = a(2)

      VELX(i) = a(3)
      VELY(i) = a(4)
      VELZ(i) = a(5)

      MASS(i) = a(6)
    }

    for (_ <- 0 until 100000) {

      java.util.Arrays.fill(dX, 0.0)
      java.util.Arrays.fill(dY, 0.0)
      java.util.Arrays.fill(dZ, 0.0)

      java.util.Arrays.fill(dvX, 0.0)
      java.util.Arrays.fill(dvY, 0.0)
      java.util.Arrays.fill(dvZ, 0.0)

      for (i <- 0 until N) {

        var WYPX = 0.0
        var WYPY = 0.0
        var WYPZ = 0.0

        for (j <- 0 until N) {

          if (i != j) {

            val dx = POSX(j) - POSX(i)
            val dy = POSY(j) - POSY(i)
            val dz = POSZ(j) - POSZ(i)

            val distSq = dx * dx + dy * dy + dz * dz
            val dist = math.sqrt(distSq)

            val skalar = G * MASS(i) * MASS(j) / distSq

            WYPX += skalar * dx / dist
            WYPY += skalar * dy / dist
            WYPZ += skalar * dz / dist
          }
        }

        WYPX /= MASS(i)
        WYPY /= MASS(i)
        WYPZ /= MASS(i)

        dvX(i) = WYPX * dT
        dvY(i) = WYPY * dT
        dvZ(i) = WYPZ * dT

        dX(i) = VELX(i) * dT
        dY(i) = VELY(i) * dT
        dZ(i) = VELZ(i) * dT
      }

      for (i <- 0 until N) {

        VELX(i) += dvX(i)
        VELY(i) += dvY(i)
        VELZ(i) += dvZ(i)

        POSX(i) += dX(i) + 0.5 * dvX(i) * dT
        POSY(i) += dY(i) + 0.5 * dvY(i) * dT
        POSZ(i) += dZ(i) + 0.5 * dvZ(i) * dT
      }
    }

    for (i <- 0 until N)
      println(f"${POSX(i)}%.15f ${POSY(i)}%.15f ${POSZ(i)}%.15f")
  }
}
