//
//  Xd+String.swift
//  Pods-XDHelper_Example
//
//  Created by Xwg on 2020/3/12.
//

import UIKit

// MARK: String
extension String: XDWrappable {}

public extension Xd where Target == String {
    
    /// 转换成 [String: Any]?
    /// - Parameter options: JSONSerialization.ReadingOptions
    func toJSON(options: JSONSerialization.ReadingOptions = []) -> [String: Any]? {
        guard let data = target.data(using: .utf8),
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: options)
            else { return nil }
        return jsonObject as? [String: Any]
    }
    
    /// 是否匹配
    ///
    /// - Parameter regex: 正则表达式
    /// - Returns: Bool
    func isMatching(_ regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: target)
    }
}
