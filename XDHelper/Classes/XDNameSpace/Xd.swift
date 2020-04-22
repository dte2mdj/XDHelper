//
//  Xd.swift
//  Pods-XDHelper_Example
//
//  Created by Xwg on 2020/3/12.
//

import Foundation

public protocol XDWrappable {
    
    associatedtype Target
    
    static var xd: Target.Type { get }
    var xd: Target { get }
}

// MARK: - Xd<T>
public extension XDWrappable {
    
    static var xd: Xd<Self>.Type {
        return Xd<Self>.self
    }
    
    var xd: Xd<Self> {
        return Xd(target: self)
    }
}

public struct Xd<Target> {
    
    var target: Target

    init(target: Target) {
        self.target = target
    }
}

// MARK: - XDArray

public protocol XDArrayWrappable: XDWrappable {
    associatedtype Element
}

public struct XDArray<Target, Element> {
    
    var target: Target
    
    init(target: Target) {
        self.target = target
    }
}

public extension XDArrayWrappable {
    
    static var xd: XDArray<Self, Element>.Type {
        return XDArray<Self, Element>.self
    }

    var xd: XDArray<Self, Element> {
        return XDArray<Self, Element>(target: self)
    }
}


// MARK: - XDDictionary
public protocol XDDictionaryWrappable: XDWrappable {
    associatedtype Key where Key: Hashable
    associatedtype Value
}

public struct XDDictionary<Target, Key: Hashable, Value> {
    
    var target: Target
    
    init(target: Target) {
        self.target = target
    }
}

public extension XDDictionaryWrappable {
    
    static var xd: XDDictionary<Self, Key, Value>.Type {
        return XDDictionary<Self, Key, Value>.self
    }
    
    var xd: XDDictionary<Self, Key, Value> {
        return XDDictionary<Self, Key, Value>(target: self)
    }
}
