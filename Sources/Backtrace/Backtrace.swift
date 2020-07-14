import Foundation
@_exported import CwlDemangle

public struct StackFrame {
    
    public let moduleName: String
    
    public let functionName: String
    
    public init(moduleName: String, functionName: String) {
        self.moduleName = moduleName
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
}

public func backtrace() -> [StackFrame] {
    Thread.callStackSymbols
        .dropFirst()
        .map { symbol in
            let components = symbol.split(separator: " ")
            
            // 0   BacktraceTests                      0x00000001080024a9 {x} + 505
            assert(components.count > 5, "Bad mangled swift symbol format: \(symbol)")
            
            let unknown = "unknown"
            
            if components.count < 2 {
                return StackFrame(moduleName: unknown, functionName: unknown)
            }
            let moduleName = String(components[1])
            
            if components.count < 6 {
                return StackFrame(moduleName: moduleName, functionName: unknown)
            }
            let functionName = components.dropFirst(3).dropLast(2).joined(separator: " ")
            
            return StackFrame(moduleName: moduleName, functionName: functionName)
        }
}
