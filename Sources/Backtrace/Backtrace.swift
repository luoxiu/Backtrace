import Foundation
@_exported import CwlDemangle

struct CallStackSymbol {
    
    let symbol: String
    
    func demangle(options: SymbolPrintOptions) -> StackFrame {
        let components = symbol.split(separator: " ")
        
        precondition(components.count > 3, "Bad symbol format: \(symbol)")
        
        let mangled = String(components[3])
        let demangled = try? parseMangledSwiftSymbol(mangled)
        
        let module = String(components[1])
        let function = demangled?.print(using: options) ?? mangled

        return StackFrame(module: module, function: function)
    }
}

public struct StackFrame {
    
    public let module: String
    
    public let function: String
}

public func backtrace(options: SymbolPrintOptions = .simplified) -> [StackFrame] {
    Thread.callStackSymbols
        .dropFirst()
        .compactMap {
            CallStackSymbol(symbol: $0).demangle(options: options)
        }
}
