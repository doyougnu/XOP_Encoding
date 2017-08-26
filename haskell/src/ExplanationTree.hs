module ExplanationTree where

import Control.Monad (unless)
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
--     * c -- "content" labels on nodes
--     * m -- "modifiers", which decorate nodes
--     * a -- "actions" associated with downward and upward movement on edges
--
type Tree c m a = Node c m a

-- A node in the explanation tree.
data Node c m a = Node c [m] [Edge c m a]
  deriving (Eq,Show)

-- | An edge in the explanation tree.
data Edge c m a
    = Child [a] (Node c m a) [a]
    | Loop  [a]
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
reverseTree (Node c ms es)
    = Node c (reverse ms) (reverse (map reverseEdge es))
  where
    reverseEdge (Child ins dest outs) = Child ins (reverseTree dest) outs
    reverseEdge loop = loop

-- | Pretty print an explanation tree.
prettyTree :: (Show c, Show m, Show a) => Tree c m a -> IO ()
prettyTree = node 0
  where
    print i s = putStrLn (replicate (i*2) ' ' ++ s)
    node i (Node c ms es) = do
      print i (show c ++ if null ms then "" else show ms)
      mapM_ (edge i) es
    edge i (Loop as) = do
      print i ("loop: " ++ show as)
    edge i (Child down n up) = do
      print i ("-->" ++ show down)
      node (i+1) n
      print i ("<--" ++ show up)


-- * Codes

-- | A generic representation of a code that incrementally extends an
--   explanation tree. A code can be viewed as an instruction for a
--   stack-based interpreter that produces an explanation tree as output.
data Code c m a
   = New c [a]  -- ^ create a new child through some actions
   | Mod m      -- ^ add a modifier to the current node
   | Act [a]    -- ^ add a self-loop to the current node
   | Pop [a]    -- ^ move up the explanation tree through some actions
 deriving (Eq,Show)


-- * Semantics

-- | Each element in the context represents a node and the incoming downward
--   actions to that node.
type Context c m a = [([a], Node c m a)]

-- | Semantics of a code as an update on the context.
--   TODO: Handle/report error cases.
code :: Code c m a -> Context c m a -> Context c m a
code (New x as) ctx
    = (as, Node x [] []) : ctx
code (Mod m) ((as, n) : ctx)
    = (as, addModifier m n) : ctx
code (Act l) ((as, n) : ctx)
    = (as, addEdge (Loop l) n) : ctx
code (Pop c2p) ((p2c, c) : (g2p, p) : ctx)
    = (g2p, addEdge (Child p2c c c2p) p) : ctx

-- | Exit a context, returning the corresponding tree.
--   TODO: Handle/report error cases.
exit :: Context c m a -> Tree c m a
exit [([],n)] = reverseTree n
exit ctx      = exit (code (Pop []) ctx)

-- | Convert a list of codes into an explanation tree.
toTree :: [Code c m a] -> Tree c m a
toTree = exit . foldl' (flip code) []

-- | An example tree. Run the following to test:
--
--   ghci> prettyTree (toTree c1)
--
c1 = [ New "Root" []
       , New "A" ["Root->A"]
         , Mod 1
         , Act ["Loop A"]
         , New "B" ["A->B", "A~>B"]
           , Mod 2
           , Mod 3
           , Pop ["A<-B"]
         , Mod 4
         , New "C" ["A->C"]
           , Act ["C1"]
           , Act ["C2.1", "C2.2"]
           , Pop ["A<-C"]
         , Pop ["Root<-A"]
       , New "D" ["A->D"]
     ]
