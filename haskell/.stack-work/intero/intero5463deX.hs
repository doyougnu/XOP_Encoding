module DocEncodings where

import ExplanationTree

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

data Expressions = Cartoon
                 | Code
                 | PseudoCode
                 | Sequence
                 | Mathematic
                 | Table
                 deriving Show

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

djk009 = [ New Algorithm
           , New Property
             , Act Definition
             , Pop
           , New Problem
             , Act Definition
             , Pop
           , New Operation
             , Act Proposal
             , Pop
           , New Complexity
             , Act Description
             , New Implementation
               , Pop
             , New Implementation
               , Act Description
         ]

