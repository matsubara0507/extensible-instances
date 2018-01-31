{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# OPTIONS_GHC -fno-warn-orphans  #-}

module Data.Extensible.Instances.Default where

import           Data.Default          (Default (..))
import           Data.Extensible
import           Data.Functor.Identity (Identity (..))
import           Data.Proxy
import           Data.Text             (Text)
import           GHC.TypeLits          (KnownSymbol)

instance Forall (KeyValue KnownSymbol Default) xs => Default (Record xs) where
  def = htabulateFor (Proxy :: Proxy (KeyValue KnownSymbol Default)) $ \_ -> Field def

instance Default a => Default (Identity a) where
  def = Identity def

instance Default Text where
  def = ""
