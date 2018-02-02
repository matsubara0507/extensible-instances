# extensible-instances

Instances of extensible data type in [extensible](https://hackage.haskell.org/package/extensible) package for any type class

## Support type class

- [`aeson`](https://hackage.haskell.org/package/aeson)
    - `FromJson` and `ToJson`
    - Behavior of `Maybe a` type is same that Aeson Generics, but its different from [example on fumieval/extensible](https://github.com/fumieval/extensible/blob/master/examples/aeson.hs).
- [`cassava`](https://hackage.haskell.org/package/cassava)
    - `ToRecord` and `ToNamedRecord`
    - `FromNamedRecord`
- [`data-default`](https://hackage.haskell.org/package/data-default)
    - `Default`

- Extensible Effects
    - [`MonadBase`](https://hackage.haskell.org/package/transformers-base/docs/Control-Monad-Base.html#t:MonadBase) with `IO`
    - [`MonadLogger`](https://hackage.haskell.org/package/monad-logger/docs/Control-Monad-Logger.html#t:MonadLogger) with `LoggerT IO`
    - [`MonadThrow`](https://hackage.haskell.org/package/exceptions/docs/Control-Monad-Catch.html#t:MonadThrow) with `IO`
    - have not written a test yet
