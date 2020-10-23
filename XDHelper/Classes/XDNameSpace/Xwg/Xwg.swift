import Foundation

// MARK: - 扩展协议
public protocol XwgWrappable {
    associatedtype XTarget
    
    static var xwg: XTarget.Type { get }
    var xwg: XTarget { get }
}

public extension XwgWrappable {
    
    static var xwg: Xwg<Self>.Type {
        return Xwg<Self>.self
    }
    
    var xwg: Xwg<Self> {
        return Xwg<Self>(self)
    }
}

// MARK: - 扩展Target
public struct Xwg<Target> {
    public let target: Target
    
    public init(_ target: Target) {
        self.target = target
    }
}

public struct XwgArray<Element> {
    public let target: [Element]

    public init(_ target: [Element]) {
        self.target = target
    }
}

public struct XwgDictionary<Key: Hashable, Value> {
    public let target: [Key: Value]

    public init(_ target: [Key: Value]) {
        self.target = target
    }
}

//MARK: - 扩展
extension Array: XwgWrappable {
    public static var xwg: XwgArray<Element>.Type {
        return XwgArray<Element>.self
    }
    
    public var xwg: XwgArray<Element> {
        return XwgArray<Element>(self)
    }
}
extension Dictionary: XwgWrappable {
    public static var xwg: XwgDictionary<Key, Value>.Type {
        return XwgDictionary<Key, Value>.self
    }
    
    public var xwg: XwgDictionary<Key, Value> {
        return XwgDictionary<Key, Value>(self)
    }
}
extension Character: XwgWrappable {}
extension String: XwgWrappable {}
extension Date: XwgWrappable {}

