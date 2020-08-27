# hs-processes-bench

A simple benchmark comparing
the Haskell [process](https://hackage.haskell.org/package/process) and
[typed-process](https://hackage.haskell.org/package/typed-process) libraries.

TL;DR: typed-process is more sophisticated and has more overhead.
Typically about 5-6 times slower as of the ghc8 timeframe.

`process` is good for simple process io using `String`s with low overhead and predictable performance.

`typed-process` strength is correctly handling complicated io process streams (uses `ByteString`s, async, and stm).


More sophisticated benchmarks can probably be thought up.
