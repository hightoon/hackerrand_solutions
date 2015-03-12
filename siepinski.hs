-- sierpinski triangles

data Point = Point Int Int deriving (Show, Eq)

addPoints :: Point -> Point -> Point
addPoints (Point x1 y1) (Point x2 y2) = Point (x1+x2) (y1+y2)

getMid :: Point -> Point -> Point
getMid (Point x1 y1) (Point x2 y2) = Point ((x1+x2) `div` 2) ((y1+y2) `div` 2)

getPntRow :: Int -> [Int] -> [Point]
getPntRow _ [] = []
getPntRow x (y:ys) = (Point x y):getPntRow x ys

getPntRows :: Point -> [Int] -> [Point]
getPntRows _ [] = []
getPntRows (Point x y) (col:cols) = 
    getPntRow (x+col) [(y-col)..(y+col)] ++ (getPntRows (Point x y) cols)

fillTriangles :: Point -> Point -> Point -> [Point]
fillTriangles (Point x1 y1) (Point x2 y2) (Point x3 y3) = 
    getPntRows (Point x1 y1) [0..(y1-y2)]

sierpinski :: Point -> Point -> Point -> Int -> [Point]
sierpinski (Point x1 y1) (Point x2 y2) (Point x3 y3) 0 =
    fillTriangles (Point x1 y1) (Point x2 y2) (Point x3 y3) 
sierpinski (Point x1 y1) (Point x2 y2) (Point x3 y3) degree =
       sierpinski (Point x1 y1) (midP12 `addPoints` Point 0 (1)) (midP13 `addPoints` Point 0 0) (degree-1)
    ++ sierpinski (midP12 `addPoints` Point 1 0) (Point x2 y2) (midP23 `addPoints` Point 0 (-1)) (degree-1)
    ++ sierpinski (midP13 `addPoints` Point 1 1) (midP23 `addPoints` Point 0 1) (Point x3 y3) (degree-1) 
    where midP12 = getMid (Point x1 y1) (Point x2 y2)
          midP13 = getMid (Point x1 y1) (Point x3 y3)
          midP23 = getMid (Point x2 y2) (Point x3 y3)

drawPoint :: [Point] -> Point -> Char
drawPoint ps (Point x y) 
    | (Point x y) `elem` ps = '1'
    | otherwise             = '_' 
    

genLine :: [Point] -> Int -> String
genLine ps x = [drawPoint ps (Point x y) | y <- [1..63]]

drawLines :: [String] -> IO ()
drawLines [] = return ()
drawLines (ln:lns) = do
    putStrLn ln
    drawLines lns 

draw :: [Point] -> IO ()
draw ps = drawLines lines
    where lines = map (genLine ps) [1..32]


main = do
    d <- getLine
    draw $ sierpinski (Point 1 32) (Point 32 1) (Point 32 63) (read d::Int)
    --print $ sierpinski (Point 1 32) (Point 32 1) (Point 32 63) 0
    
