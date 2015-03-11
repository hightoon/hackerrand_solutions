-- implementation of sierpinski triangles

genLn :: Int -> String
genLn n = [genChar x | x <- [1..63]]
    where genChar col 
            | col <= (32 - n) = '_'
            | col >= (32 + n) = '_'
            | otherwise      = '1'

genSierpinskiTriangle :: Int -> [String]
genSierpinskiTriangle 0 = []
genSierpinskiTriangle numOfRows =
    (genLn numOfRows) : (genSierpinskiTriangle (numOfRows-1))

spkIter :: [String] -> [String]
spkIter (s:ss) = 

spkTriangleIters :: [String] -> Int -> [String]
spkTriangleIters spk 0 = spk
spkTriangleIters spk numOfIter = spkTriangleIters (spkIter spk) (numOfIter-1) 

printTriangle :: [String] -> IO ()
printTriangle [] = return ()
printTriangle (s:ss) = do
    putStrLn s
    printTriangle ss     

main = do
    n <- getLine
    --srpskTriangles $ read n
    --putStrLn $ genLn (read n :: Int)
    printTriangle $ reverse $ genSierpinskiTriangle 32
      
