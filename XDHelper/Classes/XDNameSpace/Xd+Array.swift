//
//  XElementName+Array.swift
//  Pods-XDHelper_Example
//
//  Created by Xwg on 2020/3/12.
//

import Foundation

// MARK: Array
extension Array: XDArrayWrappable {}

public extension XDArray where Target == Array<Element>, Element: Equatable {
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
