import Foundation

// MARK: - 实现
public extension XwgArray {
    func aaa() {
        
    }
}

// MARK: - XwgArray 扩展
public struct XwgArray<Element> {
    public let target: [Element]

    public init(_ target: [Element]) {
        self.target = target
    }
}

public extension Array {
    static var xwg: XwgArray<Element>.Type {
        return XwgArray<Element>.self
    }
    
    var xwg: XwgArray<Element> {
        return XwgArray<Element>(self)
    }
}
