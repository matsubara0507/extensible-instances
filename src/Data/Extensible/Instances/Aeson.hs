{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TypeOperators         #-}
{-# OPTIONS_GHC -fno-warn-orphans  #-}

module Data.Extensible.Instances.Aeson where

import           Control.Applicative (liftA2)
import           Data.Aeson          hiding (KeyValue)
import           Data.Constraint
import           Data.Extensible
import qualified Data.HashMap.Strict as HM
import           Data.Monoid
import           Data.Proxy
import           Data.String         (fromString)
import           GHC.TypeLits        (KnownSymbol, symbolVal)

instance Forall (KeyValue KnownSymbol FromJSON) xs => FromJSON (Record xs) where
  parseJSON = withObject "Object" $
    \v -> hgenerateFor (Proxy :: Proxy (KeyValue KnownSymbol FromJSON)) $
    \m -> let k = symbolVal (proxyAssocKey m) in
      case HM.lookup (fromString k) v of
        Just a  -> Field . return <$> parseJSON a
        Nothing -> fail $ "Missing key: " `mappend` k

instance Forall (KeyValue KnownSymbol ToJSON) xs => ToJSON (Record xs) where
  toJSON = Object . HM.fromList . flip appEndo [] . hfoldMap getConst' . hzipWith
    (\(Comp Dict) -> Const' . Endo . (:) .
      liftA2 (,) (fromString . symbolVal . proxyAssocKey) (toJSON . getField))
    (library :: Comp Dict (KeyValue KnownSymbol ToJSON) :* xs)
