import Foundation

// MARK: - 公共协议
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

public struct Xwg<Target> {
    public let target: Target
    
    public init(_ target: Target) {
        self.target = target
    }
}
