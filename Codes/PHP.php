<?php

const G = 6.67e-11;
const DT = 0.001;

$N = intval(trim(fgets(STDIN)));

$POSX = array_fill(0, $N, 0.0);
$POSY = array_fill(0, $N, 0.0);
$POSZ = array_fill(0, $N, 0.0);

$VELX = array_fill(0, $N, 0.0);
$VELY = array_fill(0, $N, 0.0);
$VELZ = array_fill(0, $N, 0.0);

$MASS = array_fill(0, $N, 0.0);

$dX = array_fill(0, $N, 0.0);
$dY = array_fill(0, $N, 0.0);
$dZ = array_fill(0, $N, 0.0);

$dvX = array_fill(0, $N, 0.0);
$dvY = array_fill(0, $N, 0.0);
$dvZ = array_fill(0, $N, 0.0);

for ($i = 0; $i < $N; $i++) {
    $numbers = array_map(
        'floatval',
        preg_split('/\s+/', trim(fgets(STDIN)))
    );

    $POSX[$i] = $numbers[0];
    $POSY[$i] = $numbers[1];
    $POSZ[$i] = $numbers[2];

    $VELX[$i] = $numbers[3];
    $VELY[$i] = $numbers[4];
    $VELZ[$i] = $numbers[5];

    $MASS[$i] = $numbers[6];
}

for ($it = 0; $it < 100000; $it++) {

    for ($i = 0; $i < $N; $i++) {
        $dX[$i] = 0.0;
        $dY[$i] = 0.0;
        $dZ[$i] = 0.0;
        $dvX[$i] = 0.0;
        $dvY[$i] = 0.0;
        $dvZ[$i] = 0.0;
    }

    for ($i = 0; $i < $N; $i++) {

        $WYPX = 0.0;
        $WYPY = 0.0;
        $WYPZ = 0.0;

        for ($j = 0; $j < $N; $j++) {

            if ($i == $j)
                continue;

            $dx = $POSX[$j] - $POSX[$i];
            $dy = $POSY[$j] - $POSY[$i];
            $dz = $POSZ[$j] - $POSZ[$i];

            $distSq = $dx*$dx + $dy*$dy + $dz*$dz;
            $dist = sqrt($distSq);

            $skalar = G * $MASS[$i] * $MASS[$j] / $distSq;

            $WYPX += $skalar * $dx / $dist;
            $WYPY += $skalar * $dy / $dist;
            $WYPZ += $skalar * $dz / $dist;
        }

        $WYPX /= $MASS[$i];
        $WYPY /= $MASS[$i];
        $WYPZ /= $MASS[$i];

        $dvX[$i] = $WYPX * DT;
        $dvY[$i] = $WYPY * DT;
        $dvZ[$i] = $WYPZ * DT;

        $dX[$i] = $VELX[$i] * DT;
        $dY[$i] = $VELY[$i] * DT;
        $dZ[$i] = $VELZ[$i] * DT;
    }

    for ($i = 0; $i < $N; $i++) {

        $VELX[$i] += $dvX[$i];
        $VELY[$i] += $dvY[$i];
        $VELZ[$i] += $dvZ[$i];

        $POSX[$i] += $dX[$i] + 0.5 * $dvX[$i] * DT;
        $POSY[$i] += $dY[$i] + 0.5 * $dvY[$i] * DT;
        $POSZ[$i] += $dZ[$i] + 0.5 * $dvZ[$i] * DT;
    }
}

for ($i = 0; $i < $N; $i++) {
    printf("%.15f %.15f %.15f\n",
        $POSX[$i],
        $POSY[$i],
        $POSZ[$i]
    );
}

?>
