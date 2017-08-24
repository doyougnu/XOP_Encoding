module DocEncodings where

import ExplanationTree

-- * Actions

-- | Simple Sum type to enumerate all legal actions
data Actions = Abstraction
             | Assumption
             | BaseCase
             | Cases
             | Comment
             | Conclusion
             | Contrast
             | Definition
             | Derivation
             | Description
             | Example
             | Implication
             | InVivoIntro
             | Legend
             | Observation
             | Outline
             | Proof
             | Proposal
             | Solicitation
             | Summary
             deriving Show

-- * Exprressions

-- | Simple Sum type to enumerate all legal exprressions
data Exprressions = Cartoon
                 | Code
                 | PseudoCode
                 | Sequence
                 | Mathematic
                 | Table
                 deriving Show

-- * Descriptors

-- | Simple wrapper for actions and exprressions. This is needed because an edge
-- can take an action label, or an exprression label
data Descriptors = A Actions
                 | E Exprressions
                 deriving Show

-- * Contexts

-- | Simple Sum type to enumerate all legal Contexts
data Contexts = Advantages
              | Algorithm
              | Application
              | Class
              | Complexity
              | Condition
              | Constituent
              | Design
              | Disadvantages
              | Goal
              | History
              | Implementation
              | Motivation
              | Operation
              | Problem
              | Property
              | Solution
              | State
              deriving Show

-- * Modifiers

-- | Simple Sum type to enumerate all legal Modifiers Pop is commented out
-- because this is handled in a special case in Codes
data Modifiers = Push
               -- | Pop
               | Swap
               | Aside
               | Caveat
               | Pedagogical
               | Focus
               | Meta
               | Related
               | Review
               deriving Show

-- | Convenience function
run :: (Show c, Show m, Show a) => [Code c m a] -> IO ()
run = prettyTree . toTree

-- Begin Document Codes
exception = [ New Algorithm, Act Assumption ]

act = Act . A
expr = Act . E

djk009 :: [Code Contexts m Descriptors]
djk009 = [ New Algorithm
           , New Property
             , act Definition
             , expr Mathematic
             , Pop
           , New Problem
             , act Definition
             , expr Mathematic
             , Pop
           , New Operation
             , act Proposal
             , expr Cartoon
             , act Description
             , act Legend
             , act Cases
             , act Proof
             , act BaseCase
             , act Description
             , expr Mathematic
             , act Proposal
             , act Description
             , act Cases
             , act Description
             , expr Mathematic
             , act Conclusion
             , act Description
             , expr Cartoon
             , act Proposal
             , act Description
             , act Proof
             , Pop
           , New Complexity
             , act Description
             , New Implementation
               , Pop
             , New Implementation
               , act Description
         ]
