//
//  Xwg+Value.swift
//  XwgHelper
//
//  Created by Xwg on 2021/3/30.
//

import Foundation

// MARK: FixedWidthInteger
extension Int:      XwgWrappable {}
extension Int8:     XwgWrappable {}
extension Int16:    XwgWrappable {}
extension Int32:    XwgWrappable {}
extension Int64:    XwgWrappable {}
extension UInt:     XwgWrappable {}
extension UInt8:    XwgWrappable {}
extension UInt16:   XwgWrappable {}
extension UInt32:   XwgWrappable {}
extension UInt64:   XwgWrappable {}

// MARK: BinaryFloatingPoint
extension CGFloat:  XwgWrappable {}
extension Float:    XwgWrappable {}
extension Double:   XwgWrappable {}

public extension Xwg where Target: FixedWidthInteger {
 
    var km: Double { Double(target).xwg.km }
    var m: Double { Double(target).xwg.m }
    var cm: Double { Double(target).xwg.cm }
    var mm: Double { Double(target).xwg.mm }
    var ft: Double { Double(target).xwg.ft }
    
    var m2km: Double { Double(target).xwg.m2km }
    var m2cm: Double { Double(target).xwg.m2cm }
    var m2mm: Double { Double(target).xwg.m2mm }
    var m2ft: Double { Double(target).xwg.m2ft }
}

public extension Xwg where Target: BinaryFloatingPoint {
    
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
