module DocEncodings where

import ExplanationTree


-- * Codes

-- | Aspects of an explanation text, determined by grounded theory analysis.
data Aspect
   = Advantage
   | Algorithm
   | Application
   | Class
   | Complexity
   | Constituent
   | DataStructure
   | Design
   | Disadvantage
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

-- | Moves of an explanation text, determined by grounded theory analysis.
data Move
   = Abstraction
   | Assumption
   | Cases
   | Comment
   | Conclusion
   | Contrast
   | Definition
   | Derivation
   | Description
   | Example
   | Implication
   | InVivo
   | Legend
   | Observation
   | Outline
   | Proof
   | Proposal
   | Solicitation
   | Summary
  deriving Show

-- | Decorators for explanation codes can describe the notation used or
--   clarify the role of some text that do not directly advance the
--   aspect of the explanation under consideration.
data Decorator
   = Note Notation
   | Role Role
  deriving Show

-- | Notations used in explanations, determined by grounded theory analysis.
data Notation
   = Cartoon
   | Code
   | Mathematics
   | PseudoCode
   | Sequence
   | Table
  deriving Show

-- | Secondary roles of text in explanations, determined by grounded theory
--   analysis.
data Role
   = Aside
   | Caveat
   | Meta
   | Pedagogical
   | Related
   | Review
  deriving Show

-- | Convenience function
run :: [Code Aspect Move Decorator] -> IO ()
run = prettyTree . toTree

-- | AVL Tree Document Encodings
avt01 :: [Code Aspect Move Decorator]
avt01 = [
  aspect DataStructure
  , aspect Problem
    , move Description
    , move Example
    , move Proposal
    , aspect Solution
      , move InVivo
      , aspect Property
        , move Description
        , pop
      , aspect Class @@ [Role Meta]
        , pop
      , pop
    , pop
  , aspect History
    , move Description
    , pop
  , aspect Property @@ [Role Review]
    , move Definition @@ [Note Mathematics]
    , pop
  , move Definition @@ [Note Mathematics]
  , move InVivo @@ [Note Mathematics]
  , move InVivo
  , aspect Property
    , move Definition
    , move Example @@ [Note Cartoon]
    , aspect Operation
      , move Example @@ [Note Cartoon]
      , pop
    , aspect State
      , move Description
      , move Observation @@ [Note Cartoon]
      , pop
    , aspect Operation
      , move Example
      , move Observation
      , pop
    , aspect State
      , move Observation
      , move Conclusion
      , move Example @@ [Note Cartoon]
      , move Proposal @@ [Note Cartoon]
      , pop
    , aspect Problem
      , move InVivo
      , pop
    , aspect Operation
      , move Example @@ [Note Cartoon]
      , move Legend
      , move Description @@ [Note Cartoon]
      , aspect State
        , move Observation
        , pop
      , move Example @@ [Role Review, Note Code]
      , move Definition @@ [Role Review, Note Code]
      , move Comment @@ [Role Review]
      , move Comment @@ [Role Review, Note Code]
      , move Example @@ [Note Cartoon]
      , move Example @@ [Note Code]
      , pop
    , aspect Operation
      , move Description @@ [Role Related, Role Review]
      , pop
    , aspect Operation
      , move Description
      , aspect Advantage
        , pop
      , move Description
      , aspect State
        , move Example @@ [Note Cartoon]
        , move Observation @@ [Note Cartoon]
        , aspect Operation
          , move Example @@ [Note Cartoon]
          , move InVivo @@ [Note Cartoon]
          , pop
        , pop
      , pop
    , pop
  , aspect Operation
  , move Description @@ [Role Related]
  , aspect Design
    , move Description
    , move Comment @@ [Note Code]
    , move Description @@ [Note Code]
    , pop
  , move Description
  , move Definition @@ [Note Code]
  , move Definition @@ [Note Code]
  , aspect Operation
    , move Example
    , pop
  , move Definition @@ [Note Code]
  , aspect Operation @@ [Role Related]
    , move Description
    , move Description @@ [Note Code]
    , pop
  , aspect DataStructure @@ [Role Related]
    , pop
  , aspect Application
    , move Description
    , aspect Problem
      , aspect Solution
        , aspect Application
        , move Description
  ]

avt02 :: [Code Aspect Move Decorator]
avt02 = [
  aspect DataStructure
  , aspect Problem
    , aspect Solution
    , move Description
    , pop
  , aspect Property
    , move Definition
    , pop
  , aspect Property
    , move Proposal
    , aspect Problem
      , move Description
      , move Cases @@ [Note Mathematics]
      , aspect Solution
        , move Derivation @@ [Note Mathematics]
        , pop
      , pop
    , pop
  , aspect Operation
    , move Example @@ [Note Cartoon]
    , pop
  , move Description @@ [Note Code]
  , move Example @@ [Note Cartoon]
  , aspect DataStructure
    , pop
  , aspect Constituent
    , move Description
    , pop
  , move Description
  , aspect Operation
    , move InVivo
    , move Description
    , move Comment @@ [Role Aside]
    ]

avt03 :: [Code Aspect Move Decorator]
avt03 = [
        aspect DataStructure
        , move Outline
        , aspect DataStructure
          , move Comment @@ [Role Review]
        , aspect Constituent
          , move Definition
          , move Example @@ [Note Cartoon]
          , pop
        , aspect Property
          , move Definition
          , aspect Complexity
            , move Description
            , move Description @@ [Note Cartoon]
            , move Conclusion
            , move Definition
            , move InVivo
            , move Definition
            , aspect Constituent
              , move Description
              , move Comment @@ [Note Cartoon]
              , pop
            , pop
          , pop
        , aspect Property
          , move Derivation
          , move Derivation @@ [Role Pedagogical]
          , pop
        , aspect Operation
          , move Description
          , move Description
          , move Description @@ [Note Cartoon]
          , move Description @@ [Note Cartoon]
          , move Description
          , move Example @@ [Note Cartoon]
          , move Comment @@ [Role Caveat]
          , move Comment @@ [Role Caveat]
          , pop
        , aspect Application
          , aspect Complexity
            , move Description
            , pop
          , pop
        , aspect Class
          , move Description
          , move Definition
          , move InVivo
          , move Definition
          , move InVivo
          , aspect Complexity
            , move Description
            , move Description
            , pop
          , pop
        , aspect Design
        ]

avt04 :: [Code Aspect Move Decorator]
avt04 = [
        aspect DataStructure
        , aspect Problem
          , move Description
          , pop
        , aspect History
          , move Description
          , pop
        , aspect DataStructure
          , move Definition @@ [Role Related]
          , pop
        , aspect Property
          , move Definition
          , pop
        , aspect Property
          , move Description
          , move Description @@ [Note Mathematics]
          , move Observation
          , move Definition @@ [Note Mathematics]
          , move Proof
          , move Solicitation
          , move Proof
          , aspect Solution
            , move Description
            , pop
          , aspect State
            , move Description
            , move Definition
            , move Observation
            , move Comment @@ [Note Cartoon]
            , move Legend
            , move Observation
            , pop
          , aspect Operation
            , move InVivo
            , move Cases
            , move Description
            , move Observation
            , move Description
            , move Legend
            , move Description
            , move Description @@ [Note Cartoon]
            , pop
          , pop
        , aspect Operation
          , move Description
          , aspect Operation
            , move Description
            , move Observation
            , pop
          , pop
        , aspect Operation
          , move Comment @@ [Role Aside]
          , move Observation
          , move Conclusion
          , move Description
          , move Comment @@ [Role Caveat]
          , move Observation
          , move Observation
          , move Conclusion
          , move Example
          , pop
        , aspect Operation
          , aspect State
            , move Description
            , move Observation
            , pop
          , move Description
          , move Conclusion
          , move Conclusion @@ [Note Cartoon]
          , move Example
          , move Comment @@ [Note Cartoon]
          , aspect State
            , move Description
            , move Observation
            , move Conclusion @@ [Note Cartoon]
            , move Legend
            , pop
          , move Example
          , aspect State
            , move Comment @@ [Note Cartoon]
            , move Observation
            , move Implication
            , move Description
            , move Conclusion @@ [Note Cartoon]
            , pop
          , move Example
          , move Description
          , move Observation
          , move Conclusion @@ [Note Cartoon]
          , aspect Problem
            , move Description
        ]

avt05 :: [Code Aspect Move Decorator]
avt05 = [
  aspect [DataStructure]
  , aspect Disadvantage
    , move Description
    , move Example @@ [Note Cartoon]
    , move Description @@ [Note Sequence]
    , move Implication @@ [Note Sequence]
    , move Description @@ [Note Sequence]
    , move Description @@ [Note Sequence]
    , aspect History
      , move Description
      , pop
    , move Description
    , aspect Property
      , move Description
      , move Definition @@ [Note Mathematics]
      , pop
    , aspect Property
      , move Definition
      , aspect Property
        , move Definition
        , move Implication
        , pop
      , move Example @@ [Note Cartoon]
      , aspect Operation
        , move Description @@ [Note Sequence]
        , move Example @@ [Note Cartoon]
        , move Description
        , move Comment @@ [Note Sequence]
        , move Example @@ [Note Cartoon]
        , aspect State
          , move Observation
          , pop
        , move Description
        , aspect State
          , move Observation
          , pop
        , aspect State
          , move Observation
          , pop
        , aspect State
          , move Observation
          , pop
        , move Description
        , move Example @@ [Note Cartoon]
        , move Comment @@ [Note Cartoon]
        , move Description
        , aspect State
          , move Observation @@ [Note Cartoon]
          , move Proposal @@ [Note Cartoon]
          , move Description @@ [Note Cartoon]
          , move Description @@ [Note Cartoon]
          , move Description @@ [Note Cartoon]
          , move Description @@ [Note Cartoon]
          , move Conclusion
          , pop
        , move Example @@ [Note Cartoon]
        , move Example @@ [Note Cartoon]
        , aspect State
          , move Observation
          , pop
        , aspect State
          , move Observation
          , move Proposal
          , move Description @@ [Note Cartoon]
          , move Description @@ [Note Cartoon]
          , move Description @@ [Note Cartoon]
          , move Description @@ [Note Cartoon]
          , move Description @@ [Note Cartoon]
          , move Conclusion
          , pop
        , pop
      , pop
    , pop
  , aspect Operation
    , move Description
    , move Example @@ [Note Cartoon]
    , pop
  , aspect Operation
    , move Description
    , move Description @@ [Note Cartoon, Note Sequence]
    , pop
  , aspect Operation
    , move Description @@ [Note Sequence]
  ]

ms03 = [
  aspect Algorithm
  , aspect Operation
    , move Description
    , move InVivo
    , pop
  , move Definition @@ [Note Sequence, Note Cartoon]
  , aspect Motivation
    , move Description @@ [Note Mathematics]
    , pop
  , aspect Disadvantage
    , move Description @@ [Note Mathematics]
    , pop
  , aspect Operation
  ]

djk09 :: [Code Aspect Move Decorator]
djk09 = [
  aspect Algorithm
  , aspect Property
    , move Definition @@ [Note Mathematics]
    , pop
  , aspect Problem
    , move Definition @@ [Note Mathematics]
    , pop
  , aspect Operation
    , move Proposal @@ [Note Cartoon]
    , move Description
    , move Legend
    , move Cases
    , move Proof
    , move Cases
    , move Description @@ [Note Mathematics]
    , move Proposal
    , move Description
    , move Cases
    , move Description @@ [Note Mathematics]
    , move Conclusion
    , move Description @@ [Note Cartoon]
    , move Proposal
    , move Description
    , move Proof
    , pop
  , aspect Complexity
    , move Description
    , aspect Implementation
      , pop
    , aspect Implementation
      , move Description
  ]
