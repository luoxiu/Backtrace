import Foundation
@_exported import CwlDemangle

public struct StackFrame {
    
    public let module: String
    
    public let function: String
    
    public init(module: String, function: String) {
        self.module = module
        self.function = function
    }
    
    public var isFunctionMangled: Bool {
        do {
            _ = try parseMangledSwiftSymbol(function)
            return true
        } catch {
            return false
        }
    }
    
    public func resolvedFunction(options: SymbolPrintOptions) -> String {
        if let swiftSymbol = try? parseMangledSwiftSymbol(function) {
            return swiftSymbol.print(using: options)
        }
        return function
    }
}

public func backtrace() -> [StackFrame] {
    Thread.callStackSymbols
        .dropFirst()
        .map { symbol in
            let components = symbol.split(separator: " ")
            
            // 0   BacktraceTests                      0x00000001080024a9 {x} + 505
            precondition(components.count > 5, "Bad symbol format: \(symbol)")
            
            let module = String(components[1])
            let function = components.dropFirst(3).dropLast(2).joined(separator: " ")
            
            return StackFrame(module: module, function: function)
        }
}
