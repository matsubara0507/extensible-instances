{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE PolyKinds             #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE UndecidableInstances  #-}
{-# OPTIONS_GHC -fno-warn-orphans  #-}

module Data.Extensible.Instances.Default where

import           Data.Default          (Default (..))
import           Data.Extensible
import           Data.Functor.Identity (Identity (..))
import           Data.Proxy

instance WrapForall Default h xs => Default (h :* xs) where
  def = htabulateFor (Proxy :: Proxy (Instance1 Default h)) $ const def

instance Default (h (AssocValue kv)) => Default (Field h kv) where
  def = Field def

instance Default a => Default (Identity a) where
  def = Identity def
