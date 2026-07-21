import Text.Printf

g :: Double
g = 6.67e-11

dt :: Double
dt = 0.001

data Vec3 = Vec3 Double Double Double
    deriving Show

data Body = Body
    { pos  :: Vec3
    , vel  :: Vec3
    , mass :: Double
    } deriving Show

add :: Vec3 -> Vec3 -> Vec3
add (Vec3 ax ay az) (Vec3 bx by bz) =
    Vec3 (ax + bx) (ay + by) (az + bz)

sub :: Vec3 -> Vec3 -> Vec3
sub (Vec3 ax ay az) (Vec3 bx by bz) =
    Vec3 (ax - bx) (ay - by) (az - bz)

scale :: Double -> Vec3 -> Vec3
scale k (Vec3 x y z) =
    Vec3 (k*x) (k*y) (k*z)

norm :: Vec3 -> Double
norm (Vec3 x y z) =
    sqrt (x*x + y*y + z*z)

forceFrom :: Body -> Body -> Vec3
forceFrom a b =
    let
        r = sub (pos b) (pos a)
        d = norm r
    in
        if d == 0
            then Vec3 0 0 0
            else scale (g * mass a * mass b / (d*d*d)) r

acceleration :: Int -> Body -> [Body] -> Vec3
acceleration i body bodies =
    scale (1 / mass body) totalForce
  where
    totalForce =
        foldl add (Vec3 0 0 0)
        [ forceFrom body other
        | (j, other) <- zip [0..] bodies
        , i /= j
        ]

updateBody :: Double -> [Body] -> Int -> Body -> Body
updateBody dt bodies i body =
    let
        a  = acceleration i body bodies
        dv = scale dt a
        dx = scale dt (vel body)

        newVel = add (vel body) dv
        newPos = add (pos body)
                    (add dx (scale (0.5 * dt) dv))
    in
        Body newPos newVel (mass body)

step :: Double -> [Body] -> [Body]
step dt bodies =
    zipWith (updateBody dt bodies) [0..] bodies

readBody :: IO Body
readBody = do
    line <- getLine
    let [px, py, pz, vx, vy, vz, m] =
            map read (words line)
    return $
        Body
            (Vec3 px py pz)
            (Vec3 vx vy vz)
            m

printBody :: Body -> IO ()
printBody (Body (Vec3 x y z) _ _) =
    printf "%.15f %.15f %.15f\n" x y z

main :: IO ()
main = do
    n <- readLn

    bodies <- sequence [readBody | _ <- [1..n]]

    let result = iterate (step dt) bodies !! 100000

    mapM_ printBody result
