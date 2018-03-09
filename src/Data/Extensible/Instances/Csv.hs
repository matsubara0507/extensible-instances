{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TypeOperators         #-}
{-# OPTIONS_GHC -fno-warn-orphans  #-}

module Data.Extensible.Instances.Csv where

import           Data.Csv              (FromField (..), ToField (..))
import           Data.Functor.Identity (Identity (..))

instance ToField a => ToField (Identity a) where
  toField (Identity a) = toField a

instance FromField a => FromField (Identity a) where
  parseField = fmap pure . parseField
