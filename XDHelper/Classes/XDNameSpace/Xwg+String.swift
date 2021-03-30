//
//  Xwg+String.swift
//  XwgHelper
//
//  Created by Xwg on 2021/3/30.
//

import UIKit

extension String: XwgWrappable {}

// MARK: - 扩展实现
public extension Xwg where Target == String {
    
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
