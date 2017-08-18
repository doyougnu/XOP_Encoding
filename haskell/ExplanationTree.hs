module ExplanationTree where

import Data.List (foldl', reverse)


-- * Explanation Trees

-- | An explanation tree is a rose tree where each each node is labeled by
--   the "content" it represents and annotated by zero or more "modifiers".
--   Each edge is annotated by zero or more "actions" that occur when
--   traversing down the edge, and zero or more actions that occur when
--   traversing up the edge.
--
--   The type parameters represent:
--
--     * c -- "content" labels nodes
--     * m -- "modifiers" annotated nodes
--     * a -- "actions" annotated both up and down edges
--
type Tree c m a = Node c m a

-- A node in the explanation tree.
data Node c m a = Node c [m] [Edge c m a]
  deriving (Eq,Show)

-- | An edge in the explanation tree.
data Edge c m a = Edge [a] (Node c m a) [a]
  deriving (Eq,Show)

-- | Add a modifier to the given node.
addModifier :: m -> Node c m a -> Node c m a
addModifier m (Node c ms es) = Node c (m:ms) es

-- | Add an edge to the given node.
addEdge :: Edge c m a -> Node c m a -> Node c m a
addEdge e (Node c ms es) = Node c ms (e:es)

-- | Reverse all of the lists so edges, modifiers, and actions are in the
--   the order that they were added.
reverseTree :: Node c m a -> Node c m a
reverseTree (Node c ms es) = Node c (reverse ms) (reverse (map reverseEdge es))
  where
    reverseEdge (Edge ins dest outs) = Edge (reverse ins) (reverseTree dest) (reverse outs)

-- | Pretty print an explanation tree.
prettyTree :: (Show c, Show m, Show a) => Tree c m a -> IO ()
prettyTree = node 0
  where
    print i s = putStrLn (replicate (i*2) ' ' ++ s)
    node i (Node c ms es) = do
      print i (show c ++ " " ++ show ms)
      mapM_ (edge i) es
    edge i (Edge down n up) = do
      print i ("--" ++ show down ++ "->")
      node (i+1) n
      print i ("<-" ++ show up ++ "--")


-- * Codes

-- | A generic representation of a code that incrementally extends an
--   explanation tree. A code can be viewed as an instruction for a
--   stack-based interpreter that produces an explanation tree as output.
data Code c m a
   = New c  -- ^ new child of the current node
   | Mod m  -- ^ add a modifier to the current node
   | Act a  -- ^ add an action to the most recent edge
   | Pop    -- ^ move up the explanation tree
 deriving (Eq,Show)


-- * Semantics

-- | The direction that we're moving in the explanation tree. If moving up,
--   we need to remember the child and its incoming edges, and also collect
--   the upward actions from that child.
data Dir c m a = Down | Up [a] (Node c m a) [a]
  deriving (Eq,Show)

-- | Each element in the path represents a node and the incoming downward
--   actions to that node.
type Path c m a = [([a], Node c m a)]

-- | A context consists of the direction and the path to the current node.
type Context c m a = (Dir c m a, Path c m a)

-- | Semantics of a code as an update on the context.
--   TODO: Handle/report error cases.
code :: Code c m a -> Context c m a -> Context c m a
code (New x) (Down, ns)
    = (Down, ([], Node x [] []) : ns) 
code (New x) (Up p2c c c2p, (g2p, p) : ns)
    = (Down, ([], Node x [] []) : (g2p, addEdge (Edge p2c c c2p) p) : ns)
code (Mod m) (d, (as, n) : ns)
    = (d, (as, addModifier m n) : ns)
code (Act a) (Down, (p2n,n) : ns)
    = (Down, (a:p2n, n) : ns)
code (Act a) (Up p2c c c2p, ns)
    = (Up p2c c (a:c2p), ns)
code Pop (Down, (p2c, c) : ns)
    = (Up p2c c [], ns)
code Pop (Up p2c c c2p, (g2p, p) : ns)
    = (Up g2p (addEdge (Edge p2c c c2p) p) [], ns)

-- | Convert a list of codes into an explanation tree.
toTree :: [Code c m a] -> Tree c m a
toTree = exit . foldl' (flip code) (Down, [])

-- | Exit a context, returning the corresponding tree.
--   TODO: Handle/report error cases.
exit :: Context c m a -> Tree c m a
exit (Up [] c [], []) = reverseTree c
exit ctx = exit (code Pop ctx)

-- | An example tree. Run the following to test:
--   
--   ghci> prettyTree (toTree c1)
--
c1 = [ New "Root"
       , New "A"
         , Mod 1
         , Act "Root->A"
         , New "B"
           , Mod 2
           , Act "A->B"
           , Mod 3
           , Act "A~>B"
           , Pop
         , Act "B->A"
         , Mod 4
         , New "C"
           , Act "A->C"
           , Pop
         , Act "C->A"
         , Pop
       , Act "A->Root"
       , New "D"
         , Act "A->D"
         ]
