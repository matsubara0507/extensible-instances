{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MonoLocalBinds        #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE UndecidableInstances  #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Data.Extensible.Effect.Logger
    ( Logging
    , LoggerDef
    , runLoggerDef
    ) where

import           Control.Monad.IO.Class
import           Control.Monad.Logger
import           Data.Extensible
import           Data.Proxy

type Logging = LoggingT IO
type LoggerDef = "Logger" >: Logging

runLoggerDef :: (MonadIO (Eff xs)) => Eff (LoggerDef ': xs) a -> Eff xs a
runLoggerDef = peelEff0 pure $ \m k -> k =<< liftIO (runStdoutLoggingT m)

instance (Associate "Logger" Logging xs) => MonadLogger (Eff xs) where
  monadLoggerLog loc ls level msg =
    liftEff (Proxy :: Proxy "Logger") $ monadLoggerLog loc ls level msg
