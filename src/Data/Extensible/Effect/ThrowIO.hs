{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MonoLocalBinds        #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeSynonymInstances  #-}
{-# LANGUAGE UndecidableInstances  #-}
{-# OPTIONS_GHC -fno-warn-orphans  #-}

module Data.Extensible.Effect.ThrowIO
    (
    ) where

import           Control.Monad.Catch (MonadThrow (..))
import           Data.Extensible     (Associate, Eff, liftEff)
import           Data.Proxy          (Proxy (..))

instance (Associate "IO" IO xs) => MonadThrow (Eff xs) where
  throwM = liftEff (Proxy :: Proxy "IO") . throwM
