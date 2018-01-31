{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TypeOperators         #-}
{-# OPTIONS_GHC -fno-warn-orphans  #-}

module Data.Extensible.Instances.Csv where

import           Control.Applicative   (liftA2)
import           Data.Constraint
import           Data.Csv              (DefaultOrdered (..), FromField (..),
                                        FromNamedRecord (..), ToField (..),
                                        ToNamedRecord (..), ToRecord (..),
                                        namedField, namedRecord, record, (.:))
import           Data.Extensible       hiding (record)
import           Data.Functor.Identity (Identity (..))
import qualified Data.HashMap.Strict   as HM
import           Data.Monoid
import           Data.Proxy
import           Data.String           (fromString)
import           GHC.TypeLits          (KnownSymbol, symbolVal)

instance Forall (KeyValue KnownSymbol FromField) xs => FromNamedRecord (Record xs) where
  parseNamedRecord v =
    hgenerateFor (Proxy :: Proxy (KeyValue KnownSymbol FromField)) $ \m -> do
       let k = symbolVal (proxyAssocKey m)
       case HM.lookup (fromString k) v of
         Just _  -> Field . return <$> (v .: fromString k)
         Nothing -> fail $ "Missing key: " `mappend` k

instance Forall (KeyValue KnownSymbol ToField) xs => ToNamedRecord (Record xs) where
  toNamedRecord = namedRecord . flip appEndo [] . hfoldMap getConst' . hzipWith
    (\(Comp Dict) -> Const' . Endo . (:) . liftA2 namedField
      (fromString . symbolVal . proxyAssocKey) (runIdentity . getField))
    (library :: Comp Dict (KeyValue KnownSymbol ToField) :* xs)

instance Forall (KeyValue KnownSymbol ToField) xs => ToRecord (Record xs) where
  toRecord = record . flip appEndo [] . hfoldMap getConst' . hzipWith
    (\(Comp Dict) -> Const' . Endo . (:) . toField . runIdentity . getField)
    (library :: Comp Dict (KeyValue KnownSymbol ToField) :* xs)

instance Forall (KeyValue KnownSymbol ToField) xs => DefaultOrdered (Record xs) where
  headerOrder = record . flip appEndo [] . hfoldMap getConst' . hzipWith
    (\(Comp Dict) -> Const' . Endo . (:) . fromString . symbolVal . proxyAssocKey)
    (library :: Comp Dict (KeyValue KnownSymbol ToField) :* xs)
