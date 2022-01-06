module Main where

import InterpreterPrelude

import qualified SplayTree

{--
import qualified LeftList
import qualified RightList
import qualified SplayHeap
import qualified Bool
import qualified Tree
import qualified PairingHeap
import qualified SkewHeap
import qualified Scratch
--}

show_inorder :: (Eq a, Ord a, Show a) => Tree a -> String
show_inorder Leaf = " _ "
show_inorder (Node l x r) = (show_inorder l) ++ (show x) ++ (show_inorder r)

check :: Eq a => a -> a -> String
check a b = show ((==) a b)

-- Constants

example_t1 = Node (end 2) 1 (end 3)
example_t2 = Node (end 5) 4 (end 6)
example_t3 = Node (Node (end 4) 2 (end 5)) 1 (end 3)

example_bst1 = Node (end 1) 2 (end 3)
example_bst2 = Node (end 4) 5 (end 6)
example_bst3 = Node (Node (end 1) 2 (end 3)) 4 (end 5)

to5 = [1, 2, 3, 4, 5] :: [Integer]
to5r = make_list_right to5
to5l = make_list_left to5

main :: IO ()
main = mapM_ putStrLn [
    show $ root $ SplayTree.splay 1 example_bst3,
    show $ root $ SplayTree.splay 2 example_bst3,
    show $ root $ SplayTree.splay 3 example_bst3,
    show $ root $ SplayTree.splay 4 example_bst3,
    show $ root $ SplayTree.splay 5 example_bst3,
    show $ root $ SplayTree.splay 6 example_bst3,
    show $ bst example_t1,
    show $ bst example_t2,
    show $ bst example_t3,
    show $ bst example_bst1,
    show $ bst example_bst2,
    show $ bst example_bst3
  ]
