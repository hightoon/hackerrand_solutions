
takeAllWhile :: (Int->Bool) -> [Int] -> [Int]
takeAllWhile _ [] = []
takeAllWhile con (x:xs)
    | con x == True = x:(takeAllWhile con xs)
    | otherwise = takeAllWhile con xs

elemLookup :: Int -> Int -> [Int] -> Int
elemLookup e n xs
    | length elems < n = -1
    | otherwise        = 1
    where elems = [x | x <- xs, x == e]

elemFilter :: Int -> [Int] -> [Int]
elemFilter _ [] = []
elemFilter n (x:xs)
    | elemLookup x n (x:xs) > 0 = x : (elemFilter n (takeAllWhile (/=x) xs))
    | otherwise = elemFilter n (takeAllWhile (/=x) xs)

solve n l =
    (unwords . map show . elemFilter n) l 

solveCases :: Int -> [String] -> [String] 
solveCases 0 _ = []
solveCases numOfCases (x1:x2:xs)  = 
    (solve numOfElem) list2filter : solveCases (numOfCases-1) xs
    where numOfElem = (head . tail) $ map (read::String->Int) $ words x1
          list2filter = map (read::String->Int) $ words x2

manipResult :: [String] -> String
manipResult [] = ""
manipResult (x:xs) 
    | x == "" = "-1\n" ++ manipResult xs
    | otherwise = x ++ "\n" ++ manipResult xs

main = do
    input <- getContents
    let numOfCases = ((read::String->Int) . head . lines) input
    let cases = (tail . lines) input
    let result = solveCases numOfCases cases
    let resStr = manipResult result 
    putStr resStr

    
