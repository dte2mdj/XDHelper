import Foundation

// MARK: - 扩展实现
public extension XwgDictionary {
    /// 转换成 Data?
    /// - Parameter options: JSONSerialization.WritingOptions
    func toData(options: JSONSerialization.WritingOptions = []) -> Data? {
        return try? JSONSerialization.data(withJSONObject: target, options: options)
    }
    
    /// 转换成 String
    /// - Parameters:
    ///   - options: JSONSerialization.WritingOptions
    func toJSONString(options: JSONSerialization.WritingOptions = []) -> String? {
        guard let data = toData(options: options) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

// MARK: - XwgDictionary 扩展
public struct XwgDictionary<Key: Hashable, Value> {
    public let target: [Key: Value]

    public init(_ target: [Key: Value]) {
        self.target = target
    }
}

public extension Dictionary {
    static var xwg: XwgDictionary<Key, Value>.Type {
        return XwgDictionary<Key, Value>.self
    }
    
    var xwg: XwgDictionary<Key, Value> {
        return XwgDictionary<Key, Value>(self)
    }
}
