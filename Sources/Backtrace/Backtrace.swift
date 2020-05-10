import Foundation
import CwlDemangle

public func backtrace(options: SymbolPrintOptions = .simplified) -> [String] {
    Thread.callStackSymbols
        .dropFirst()
        .map {
            let components = $0.split(separator: " ")
            guard components.count > 3 else { return $0 }
            
            let mangled = String(components[3])
            
            guard let parsed = try? parseMangledSwiftSymbol(mangled) else {
                return $0
            }
            
            return $0.replacingOccurrences(
                of: mangled,
                with: parsed.print(using: options)
            )
        }
}
