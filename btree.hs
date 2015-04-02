{--
  Binary Tree implementation
  btree.hs
--}

data BTree a = Node a (BTree a) (BTree a) | Empty
               deriving (Eq, Show)

--data Direction = L | R deriving (Show, Eq)
--type Directions = [Direction]

data Crumb a = LeftCrumb a (BTree a) | RightCrumb a (BTree a) deriving (Show)
type Crumbs a = [Crumb a]

root :: a -> BTree a
root x = Node x Empty Empty

goUp :: (BTree a, Crumbs a) -> (BTree a, Crumbs a)
goUp (t, LeftCrumb x r:cs) = (Node x t r, cs)
goUp (t, RightCrumb x l:cs) = (Node x l t, cs)

--attach :: (a, a) -> BTree a -> BTree a
--attach (le, re) Node x l r

goLeft :: (BTree a, Crumbs a) -> (BTree a, Crumbs a)
goLeft (Node x l r, cs) = (l, LeftCrumb x r:cs)

goRight :: (BTree a, Crumbs a) -> (BTree a, Crumbs a)
goRight (Node x l r, cs) = (r, RightCrumb x l:cs)

main = do
  print $ root 1
