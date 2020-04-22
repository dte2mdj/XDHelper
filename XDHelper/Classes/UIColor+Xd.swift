//
//  Xd+UIColor.swift
//  Pods-XDHelper_Example
//
//  Created by Xwg on 2020/3/12.
//

import Foundation

// MARK: UIColor
extension UIColor: XDWrappable {}

public extension Xd where Target == UIColor {
    
    /// 将16进制色值->Rgba
    ///
    /// - Parameter hex: 需要转换的色值,支持缩写色值（如果无效，则返回黑色即：r,g,b均等于0）
    /// - Returns: Rgba结构体
    static func fromHex(_ hex: String) -> UIColor {
        
        /// 1、对hexString进行处理
        // 1.1 去除左右空格
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        // 1.2 去标识（"0X": 16进制 "#": 颜色值）
        if cString.hasPrefix("0X") {cString = String(cString["OX".endIndex...])}
        if cString.hasPrefix("#") {cString = String(cString["#".endIndex...])}
        // 1.3 对有效值进行判断处理
        // 1.3.1 缩写色值进行复原(abc对应aabbcc 例：829 == 882299、a83 == aa8833)
        if cString.count == 3 {
            var tmpString: String = ""
            for character in cString {
                tmpString += "\(character)\(character)"
            }
            cString = tmpString
        }
            // 1.3.2 取6位有效色值
        else if cString.count >= 6 {
            cString = String(cString[..<cString.index(cString.startIndex, offsetBy: 6)])
        }
            // 1.3.3 无效色值，返回默认色值：黑色
        else {
            return .black
        }
        
        /// 2、取出r g b 对应字符串
        let gStartIndex = cString.index(cString.startIndex, offsetBy: 2)
        let gEndIndex = cString.index(cString.endIndex, offsetBy: -2)
        
        let rString = String(cString[..<gStartIndex])
        let gString = String(cString[gStartIndex..<gEndIndex])
        let bString = String(cString[gEndIndex...])
        
        var r: UInt64 = 0x0
        var g: UInt64 = 0x0
        var b: UInt64 = 0x0
        
        Scanner(string: rString).scanHexInt64(&r)
        Scanner.init(string: gString).scanHexInt64(&g)
        Scanner.init(string: bString).scanHexInt64(&b)
        
        return rgba(r: Int(r), g: Int(g), b: Int(b), a: 1)
    }
    
    /// rgba 颜色 (默认：黑色)
    /// - Parameters:
    ///   - r: 红（0...255）
    ///   - g: 绿（0...255）
    ///   - b: 蓝（0...255）
    ///   - a: 透明度（0...1）
    static func rgba(r: Int = 0, g: Int = 0, b: Int = 0, a: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
}

public extension Xd where Target == UIColor {
    
    /// 获取红色
    var red: CGFloat {
        var value: CGFloat = 0
        target.getRed(&value, green: nil, blue: nil, alpha: nil)
        return value
    }
    /// 获取绿色
    var green: CGFloat {
        var value: CGFloat = 0
        target.getRed(nil, green: &value, blue: nil, alpha: nil)
        return value
    }
    /// 获取蓝色
    var blue: CGFloat {
        var value: CGFloat = 0
        target.getRed(nil, green: nil, blue: &value, alpha: nil)
        return value
    }
    /// 获取透明度
    var alpha: CGFloat {
        var value: CGFloat = 0
        target.getRed(nil, green: nil, blue: nil, alpha: &value)
        return value
    }
}
