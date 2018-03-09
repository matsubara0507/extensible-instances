{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Test.Data.Extensible.Instances.Default where

import           Data.Default                      (def)
import           Data.Extensible
import           Data.Extensible.Instances.Default ()
import           Test.Tasty
import           Test.Tasty.HUnit

type Sample = Record
    '[ "id" >: Int
     , "name" >: String
     , "follow" >: [Int]
     ]

sample :: Sample
sample
    = #id @= 0
   <: #name @= ""
   <: #follow @= []
   <: nil

test_default :: [TestTree]
test_default =
  [ testCase "def value" $ def @?= sample ]
