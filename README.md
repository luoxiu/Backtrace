# Backtrace

Call stack for humans.

## Usage

```swift
let callstack = backtrace()
```

### before

```swift
// Thread.callStackSymbols

0   BacktraceTests                      0x00000001023bcd8a $s14BacktraceTests1ayyxlF + 282
1   BacktraceTests                      0x00000001023bd148 $s14BacktraceTests1byySiF + 40
2   BacktraceTests                      0x00000001023bd17e $s14BacktraceTests1cyyySiXEF + 46
3   BacktraceTests                      0x00000001023bc574 $s14BacktraceTests1dyyF + 20
4   BacktraceTests                      0x00000001023bc559 $s14BacktraceTestsAAC11testExampleyyF + 25
5   BacktraceTests                      0x00000001023bc5ab $s14BacktraceTestsAAC11testExampleyyFTo + 43
```

### after

```swift
// backtrace()

1   BacktraceTests                      0x00000001023bce5f BacktraceTests.a<A>(A) -> () + 495
2   BacktraceTests                      0x00000001023bd148 BacktraceTests.b(Swift.Int) -> () + 40
3   BacktraceTests                      0x00000001023bd17e BacktraceTests.c((Swift.Int) -> ()) -> () + 46
4   BacktraceTests                      0x00000001023bc574 BacktraceTests.d() -> () + 20
5   BacktraceTests                      0x00000001023bc559 BacktraceTests.BacktraceTests.testExample() -> () + 25
```
