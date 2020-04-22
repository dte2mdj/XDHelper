//
//  Xd+Value.swift
//  Pods-XDHelper_Example
//
//  Created by Xwg on 2020/3/14.
//

import Foundation

// MARK: FixedWidthInteger
extension Int: XDWrappable {}
extension Int8: XDWrappable {}
extension Int16: XDWrappable {}
extension Int32: XDWrappable {}
extension Int64: XDWrappable {}
extension UInt: XDWrappable {}
extension UInt8: XDWrappable {}
extension UInt16: XDWrappable {}
extension UInt32: XDWrappable {}
extension UInt64: XDWrappable {}

// MARK: BinaryFloatingPoint
extension CGFloat: XDWrappable {}
extension Float: XDWrappable {}
extension Float80: XDWrappable {}
extension Double: XDWrappable {}

public extension Xd where Target: FixedWidthInteger {
 
    var km: Double { Double(target).xd.km }
    var m: Double { Double(target).xd.m }
    var cm: Double { Double(target).xd.cm }
    var mm: Double { Double(target).xd.mm }
    var ft: Double { Double(target).xd.ft }
    
    var m2km: Double { Double(target).xd.m2km }
    var m2cm: Double { Double(target).xd.m2cm }
    var m2mm: Double { Double(target).xd.m2mm }
    var m2ft: Double { Double(target).xd.m2ft }
}

public extension Xd where Target: BinaryFloatingPoint {
    
    var km: Double { return Double(target) * 1_000.0 }
    var m: Double { return Double(target) }
    var cm: Double { return Double(target) / 100.0 }
    var mm: Double { return Double(target) / 1_000.0 }
    var ft: Double { return Double(target) / 3.28084 }
    
    var m2km: Double { return Double(target) / 1_000.0 }
    var m2cm: Double { return Double(target) * 100.0 }
    var m2mm: Double { return Double(target) * 1_000.0 }
    var m2ft: Double { return Double(target) * 3.28084 }
}
