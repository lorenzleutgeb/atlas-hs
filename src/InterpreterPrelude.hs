module InterpreterPrelude
  ( module InterpreterPrelude
  ) where

data Tree a = Leaf | Node (Tree a) a (Tree a)
  deriving (Eq, Show, Functor)

--data Tree a where
--  Leaf :: Tree a
--  Node :: Tree a -> a -> Tree a -> Tree a

end :: a -> Tree a
end x = Node Leaf x Leaf

root :: Tree a -> Maybe a
root Leaf = Nothing
root (Node _ x _) = Just x

checkBound :: (a -> a -> Bool) -> Maybe a -> a -> Bool
checkBound _ Nothing _ = True
checkBound o (Just x) y = x `o` y

sandwich :: Ord a => Maybe a -> Maybe a -> a -> Bool
sandwich low upp x = checkBound (<) low x && checkBound (>) upp x

isBST' :: (Eq a, Ord a) => Maybe a -> Maybe a -> Tree a -> Bool
isBST' low upp Leaf = True
isBST' low upp (Node l x r) = sandwich low upp x &&
                              isBST' low (Just x) l &&
                              isBST' (Just x) upp r

bst :: (Eq a, Ord a) => Tree a -> Bool
bst = isBST' Nothing Nothing

make_list_left :: [a] -> Tree a
make_list_left [] = Leaf
make_list_left (x:xs) = Node (make_list_left xs) x Leaf

make_list_right :: [a] -> Tree a
make_list_right [] = Leaf
make_list_right (x:xs) = Node Leaf x (make_list_right xs)

read_left :: Tree a -> [a]
read_left Leaf = []
read_left (Node l x r) = x:(read_left l)

read_right :: Tree a -> [a]
read_right Leaf = []
read_right (Node l x r) = x:(read_right r)

-- Utility functions to compute potentials

log' :: Integer -> Double
log' n = (logBase 2 (fromInteger n))

leaves :: Tree a -> Integer
leaves Leaf = 1
leaves (Node l _ r) = (leaves l) + (leaves r)

rank :: Tree a -> Double
rank Leaf = 0
rank (Node l _ r) = (rank l) + (log' (leaves l)) + (rank r) + (log' (leaves r))
