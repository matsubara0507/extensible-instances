{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Test.Data.Extensible.Instances.Csv where

import           Data.ByteString.Lazy          (ByteString)
import           Data.Csv                      (Header, decodeByName, encode,
                                                encodeByName)
import           Data.Extensible
import           Data.Extensible.Instances.Csv ()
import           Data.Text                     (Text)
import qualified Data.Vector                   as V
import           Test.Tasty
import           Test.Tasty.HUnit

type Sample = Record
    '[ "id" >: Int
     , "name" >: Text
     ]

sample :: Sample
sample
    = #id @= 123
   <: #name @= "matsubara"
   <: nil

header :: Header
header = V.fromList ["id", "name"]

sampleCsv :: ByteString
sampleCsv = "123,matsubara\r\n"

sampleCsvWithName :: ByteString
sampleCsvWithName = "id,name\r\n123,matsubara\r\n"

test_csv :: [TestTree]
test_csv =
  [ testCase "decode by name" $
      decodeByName sampleCsvWithName @?= Right (header, V.fromList [sample])
  , testCase "encode" $
      encode [sample] @?= sampleCsv
  , testCase "encode by name" $
      encodeByName header [sample] @?= sampleCsvWithName
  ]
