import Foundation
@_exported import CwlDemangle

struct CallStackSymbol {
    
    let symbol: String
    
    func parse(options: SymbolPrintOptions) -> StackFrame {
        let components = symbol.split(separator: " ")
        
        // 0   BacktraceTests                      0x00000001080024a9 {x} + 505
        precondition(components.count > 5, "Bad symbol format: \(symbol)")
        
        let module = String(components[1])
        
        var function: String
        
        let mangled = String(components[3])
        if let demangled = try? parseMangledSwiftSymbol(mangled).print(using: options) {
            function = demangled
        } else {
            function = components.dropFirst(3).dropLast(2).joined(separator: " ")
        }
        
        return StackFrame(module: module, function: function)
    }
}

public struct StackFrame: Codable {
    
    public let module: String
    
    public let function: String
    
    public init(module: String, function: String) {
        self.module = module
        self.function = function
    }
}

public func backtrace(options: SymbolPrintOptions = .default) -> [StackFrame] {
    Thread.callStackSymbols
        .dropFirst()
        .compactMap {
            CallStackSymbol(symbol: $0).parse(options: options)
        }
}
