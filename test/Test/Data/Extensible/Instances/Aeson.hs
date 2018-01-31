{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TypeOperators     #-}

module Test.Data.Extensible.Instances.Aeson where

import           Data.Aeson                      (decode, encode)
import           Data.ByteString.Lazy            (ByteString)
import           Data.Extensible
import           Data.Extensible.Instances.Aeson ()
import           Data.Text                       (Text)
import           Data.Text.Lazy.Encoding         (encodeUtf8)
import           Test.Tasty
import           Test.Tasty.HUnit
import           Text.Shakespeare.Text

type Sample = Record
    '[ "id" >: Int
     , "name" >: Text
     , "follow" >: [Int]
     ]

sample :: Sample
sample
    = #id @= 123
   <: #name @= "matsubara"
   <: #follow @= [456,789]
   <: nil

sampleJson :: ByteString
sampleJson = encodeUtf8
  [lt|{"name":"matsubara","id":123,"follow":[456,789]}|]

test_aeson :: [TestTree]
test_aeson =
  [ testCase "decode" $
      decode sampleJson @?= Just sample
  , testCase "encode" $
      encode sample @?= sampleJson
  ]
