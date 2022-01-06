module SplayTree
  ( module SplayTree,
  )
where

import InterpreterPrelude

contains :: (Eq a, Ord a) => a -> Tree a -> Bool
contains a t = root (splay a t) == (Just a)

splay :: (Eq a, Ord a) => a -> Tree a -> Tree a
splay a t = case t of
  Leaf -> Leaf
  Node cl c cr ->
    if a == c
      then t
      else
        if a < c
          then case cl of
            Leaf -> Node Leaf c cr
            Node bl b br ->
              if a == b
                then Node bl a (Node br c cr)
                else
                  if a < b
                    then case bl of
                      Leaf -> Node Leaf b (Node br c cr)
                      bl -> case splay a bl of
                        Leaf -> Leaf
                        Node al a1 ar -> Node al a1 (Node ar b (Node br c cr))
                    else case br of
                      Leaf -> Node bl b (Node Leaf c cr)
                      br -> case splay a br of
                        Leaf -> Leaf
                        Node al a1 ar -> Node (Node bl b al) a1 (Node ar c cr)
          else case cr of
            Leaf -> Node cl c Leaf
            Node bl b br ->
              if a == b
                then Node (Node cl c bl) a br
                else
                  if a < b
                    then case bl of
                      Leaf -> Node (Node cl c Leaf) b br
                      bl -> case splay a bl of
                        Leaf -> Leaf
                        Node al a1 ar -> Node (Node cl c al) a1 (Node ar b br)
                    else case br of
                      Leaf -> Node (Node cl c bl) b Leaf
                      br -> case splay a br of
                        Leaf -> Leaf
                        Node al a1 ar -> Node (Node (Node cl c bl) b al) a1 ar
