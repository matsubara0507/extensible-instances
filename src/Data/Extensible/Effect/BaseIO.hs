{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MonoLocalBinds        #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeSynonymInstances  #-}
{-# OPTIONS_GHC -fno-warn-orphans  #-}

module Data.Extensible.Effect.BaseIO
    (
    ) where

import           Control.Monad.Base (MonadBase (..))
import           Data.Extensible    (Associate, Eff, liftEff)
import           Data.Proxy         (Proxy (..))

instance (Associate "IO" IO xs) => MonadBase IO (Eff xs) where
  liftBase = liftEff (Proxy :: Proxy "IO")
