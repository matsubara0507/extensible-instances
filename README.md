# extensible-instances

Instances of extensible data type in [extensible](https://hackage.haskell.org/package/extensible) package for any type class

## Support type class

- ~~[`aeson`](https://hackage.haskell.org/package/aeson)~~
    - supported by `extensible-0.4.7.2`
- ~~[`cassava`](https://hackage.haskell.org/package/cassava)~~
    - supported by `extensible-0.4.7.2`
- [`data-default`](https://hackage.haskell.org/package/data-default)
    - `Default`

- Extensible Effects
    - [`MonadBase`](https://hackage.haskell.org/package/transformers-base/docs/Control-Monad-Base.html#t:MonadBase) with `IO`
    - [`MonadLogger`](https://hackage.haskell.org/package/monad-logger/docs/Control-Monad-Logger.html#t:MonadLogger) with `LoggerT IO`
    - [`MonadThrow`](https://hackage.haskell.org/package/exceptions/docs/Control-Monad-Catch.html#t:MonadThrow) with `IO`
    - have not written a test yet
