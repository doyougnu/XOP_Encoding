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
              | DataStructure
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

djk09 :: [Code Contexts m Descriptors]
djk09 = [ New Algorithm
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

avt01 :: [Code Contexts Modifiers Descriptors]
avt01 = [ New DataStructure
          , New Problem
            , act Description
            , act Example
            , act Proposal
            , New Solution
              , act InVivoIntro
              , New Condition
                , act Description
                , Pop
              , New Class
                , Mod Meta
                , Pop
              , Pop
            , Pop
          , New History
            , act Description
            , Pop
          , New Property -- here
            , Mod Review
            , act Definition
            , expr Mathematic
            , Pop
          , act Definition
          , act InVivoIntro
          , expr Mathematic
          , act InVivoIntro
          , New Property
            , act Definition
            , act Example
            , expr Cartoon
            , New Operation
              , act Example
              , expr Cartoon
              , Pop
            , New State
              , act Description
              , act Observation
              , expr Cartoon
              , Pop
            , New Operation
              , act Example
              , act Observation
              , Pop
            , New State
              , act Observation
              , act Conclusion
              , act Example
              , act Proposal
              , expr Cartoon
              , Pop
            , New Problem
              , act InVivoIntro
              , Pop
            , New Operation
              , act Example
              , expr Cartoon
              , act Legend
              , act Description
              , expr Cartoon
              , New State
                , act Observation
                , Pop
              , act Example
              , Mod Review
              , expr Code
              , act Definition
              , Mod Review
              , expr Code
              , Mod Review
              , expr Code
              , Mod Review
              , expr Cartoon
              , act Example
              , expr Code
              , act Example
              , Pop
            , New Operation
              , act Description
              , Mod Related
              , Mod Review
              , Pop
            , New Operation
              , act Description
              , New Advantages
                , Pop
              , act Description
              , New State
                , act Example
                , act Observation
                , expr Cartoon
                , New Operation
                  , act Example
                  , act InVivoIntro
                  , expr Cartoon
                  , Pop
                , Pop
              , Pop
            , Pop
          , New Operation
          , act Description
          , Mod Related
            , New Design
            , act Description
            , expr Code
            , expr Code
            , act Description
            , Pop
          , act Description
          , expr Code
          , act Definition
          , expr Code
          , act Definition
          , New Operation
            , act Example
            , Pop
          , expr Code
          , act Definition
          , New Operation
            , Mod Related
            , act Description
            , expr Code
            , act Description
            , expr Code
            , act Description
            , Pop
          , New DataStructure
            , Mod Related
            , Pop
          , New Application
            , act Description
            , New Problem
              , New Solution
                , New Application
                , act Description
        ]
