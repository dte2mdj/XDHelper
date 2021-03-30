//
//  Xwg+Array.swift
//  XwgHelper
//
//  Created by Xwg on 2021/3/30.
//

import Foundation

// MARK: - 实现
public extension XwgArray where Element: Equatable {
    /// 去重：Return array with all duplicate elements removed.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].removeDuplicates() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    func removeDuplicates() -> [Element] {
        return target.reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}

