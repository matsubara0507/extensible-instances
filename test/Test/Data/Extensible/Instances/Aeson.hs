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
     , "email" >: Maybe Text
     ]

sample1 :: Sample
sample1
    = #id @= 123
   <: #name @= "matsubara"
   <: #follow @= [456,789]
   <: #email @= Just "example"
   <: nil

sample2 :: Sample
sample2
    = #id @= 123
   <: #name @= "matsubara"
   <: #follow @= [456,789]
   <: #email @= Nothing
   <: nil

sampleJson :: ByteString
sampleJson = encodeUtf8
  [lt|{"email":"example","name":"matsubara","id":123,"follow":[456,789]}|]

sampleJsonNull :: ByteString
sampleJsonNull = encodeUtf8
  [lt|{"email":null,"name":"matsubara","id":123,"follow":[456,789]}|]

sampleJsonNon :: ByteString
sampleJsonNon = encodeUtf8
  [lt|{"name":"matsubara","id":123,"follow":[456,789]}|]

test_aeson :: [TestTree]
test_aeson =
  [ testCase "decode" $
      decode sampleJson @?= Just sample1
  , testCase "decode: null field" $
      decode sampleJsonNull @?= Just sample2
  , testCase "decode: non field" $
      decode sampleJsonNon @?= Just sample2
  , testCase "encode" $
      encode sample1 @?= sampleJson
  , testCase "encode: maybe" $
      encode sample2 @?= sampleJsonNull
  ]
