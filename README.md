# Backtrace

Call stack for humans.

## Usage

```swift
let callstack = backtrace()
```

### before

```swift
// Thread.callStackSymbols -> [String]

0   BacktraceTests                      0x00000001023bcd8a $s14BacktraceTests1ayyxlF + 282
1   BacktraceTests                      0x00000001023bd148 $s14BacktraceTests1byySiF + 40
2   BacktraceTests                      0x00000001023bd17e $s14BacktraceTests1cyyySiXEF + 46
3   BacktraceTests                      0x00000001023bc574 $s14BacktraceTests1dyyF + 20
4   BacktraceTests                      0x00000001023bc559 $s14BacktraceTestsAAC11testExampleyyF + 25
5   BacktraceTests                      0x00000001023bc5ab $s14BacktraceTestsAAC11testExampleyyFTo + 43
```

### after

```swift
// backtrace(options: .default) -> [StackFrame]

StackFrame(module: "BacktraceTests", function: "BacktraceTests.d<A>(A) -> ()")
StackFrame(module: "BacktraceTests", function: "BacktraceTests.c(Swift.Int) -> ()")
StackFrame(module: "BacktraceTests", function: "BacktraceTests.b((Swift.Int) -> ()) -> ()")
StackFrame(module: "BacktraceTests", function: "BacktraceTests.a() -> ()")
StackFrame(module: "BacktraceTests", function: "BacktraceTests.BacktraceTests.testBacktrace() -> ()")
StackFrame(module: "BacktraceTests", function: "@objc BacktraceTests.BacktraceTests.testBacktrace() -> ()")
```
