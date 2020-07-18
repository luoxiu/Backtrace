import Foundation
@_exported import CwlDemangle

public struct StackFrame {
    
    public let symbol: String
    
    public let functionName: String
    
    public init(symbol: String, functionName: String) {
        self.symbol = symbol
        self.functionName = functionName
    }
    
    public var isFunctionNameMangled: Bool {
        do {
            _ = try parseMangledSwiftSymbol(functionName)
            return true
        } catch {
            return false
        }
    }
    
    public func resolvedFunctionName(using options: SymbolPrintOptions) -> String {
        if let parsed = try? parseMangledSwiftSymbol(functionName) {
            return parsed.print(using: options)
        }
        return functionName
    }
    
    public func symbolWithResolvedFunctionName(using options: SymbolPrintOptions) -> String {
        symbol.replacingOccurrences(of: functionName, with: resolvedFunctionName(using: options))
    }
}

public func backtrace() -> [StackFrame] {
    Thread.callStackSymbols
        .dropFirst()
        .map { symbol in
            // 0   BacktraceTests                      0x00000001080024a9 {x} + 505
            
            let components = symbol.split(separator: " ")
            
            if components.count < 6 {
                assertionFailure("Bad mangled swift symbol format: \(symbol)")
                return StackFrame(symbol: symbol, functionName: "unknown")
            }
            
            let functionName = components.dropFirst(3).dropLast(2).joined(separator: " ")
            
            return StackFrame(symbol: symbol, functionName: functionName)
        }
}
