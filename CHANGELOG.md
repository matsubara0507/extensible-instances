# Changelog for extensible-instances

## Unreleased changes

- Remove instances
    - `FromJson`, `ToJson` in `aeson`
    - `ToRecord`, `ToNamedRecord`, `FromNamedRecord` in `cassava`
        - But, Add `ToField` and `FromField` instances for `Identity a` type
    - above instances support by `extensible` from v0.4.7.2
- Refactor: `Default` intsnace
    - Remove instance for `Text` type (please use: https://hackage.haskell.org/package/data-default-instances-text)

## 0.1.0

- Write instance
    - `FromJson`, `ToJson` in `aeson`
    - `ToRecord`, `ToNamedRecord`, `FromNamedRecord` in `cassava`
    - `Default` in `data-default`
    - `MonadBase` in `transformers-base`
    - `MonadLogger` in `monad-logger`
    - `MonadThrow` in `exceptions`
