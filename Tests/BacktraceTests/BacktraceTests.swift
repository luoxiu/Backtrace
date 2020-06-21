import XCTest
@testable import Backtrace

final class BacktraceTests: XCTestCase {
    func testBacktrace() {
        a()
    }

    static var allTests = [
        ("testBacktrace", testBacktrace),
    ]
}

func d<T>(_ x: T) {
    let results = [
        "BacktraceTests.d<A>(A) -> ()",
        "BacktraceTests.c(Swift.Int) -> ()",
        "BacktraceTests.b((Swift.Int) -> ()) -> ()",
        "BacktraceTests.a() -> ()",
        "BacktraceTests.BacktraceTests.testBacktrace() -> ()"
    ]
    
    backtrace(options: .default).forEach {
        print($0)
    }
    
    let functions = backtrace(options: .default)
        .map {
            $0.function
        }
    for (a, b) in zip(functions, results) {
        XCTAssertEqual(a, b)
    }
}

func c(_ x: Int) {
    d(x)
}

func b(_ fn: (Int) -> Void) {
    fn(1)
}

func a() {
    b(c)
}


