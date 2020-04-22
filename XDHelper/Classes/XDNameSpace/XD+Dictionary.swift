//
//  Xd+Dictionary.swift
//  Pods-XDHelper_Example
//
//  Created by Xwg on 2020/3/12.
//

import Foundation

// MARK: Dictionary
extension Dictionary: XDDictionaryWrappable {}

public extension XDDictionary where Target == Dictionary<Key, Value> {
    
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

