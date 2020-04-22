//
//  Xd+UIView.swift
//  Pods-XDHelper_Example
//
//  Created by Xwg on 2020/3/12.
//

import Foundation

// MARK: UIView
extension UIView: XDWrappable {}

public extension Xd where Target == UIView {
    /// 在当前屏幕的 frame
    var frameInScreen: CGRect {
        /// 先判断是否有父视图，如果没有父视图，直接返回视图的位置就行
        
        guard let superView = target.superview else { return target.frame }
        /**
         判断父视图是否是UIScrollView或者继承自UIScrollView
         先使用视图在屏幕上的位置使用视图的位置与父视图的位置X与Y分别相加
         如果父视图不是UIScrollView并且不继承自UIScrollView，则直接返回结果
         如果父视图是UIScrollView或者继承自UIScrollView
         还需要分别减去UIScrollView的scrollViewOffset.x和scrollViewOffset.y，然后返回结果
         */
        let pointInScreen: CGPoint
        if let scrollView = superView as? UIScrollView {
            let position = CGPoint.init(x: target.frame.origin.x, y: target.frame.origin.y)
            let superPosition = superView.xd.frameInScreen
            let scrollViewOffset = scrollView.contentOffset
            pointInScreen = CGPoint(x: superPosition.minX + position.x - scrollViewOffset.x ,
                                    y: superPosition.minY + position.y - scrollViewOffset.y)
            
        } else {
            let superPosition = superView.xd.frameInScreen
            let position = target.frame.origin
            pointInScreen = CGPoint(x: superPosition.minX + position.x,
                                    y: superPosition.minY + position.y)
        }
        
        return CGRect(origin: pointInScreen, size: target.frame.size)
    }
}

// MARK: UIResponder & UITextInput
public extension Xd where Target: UIResponder & UITextInput {
    /// 正在拼写汉字 (textDidChange 中有效)
    var isSpellingChineseCharacters: Bool {
        guard target.textInputMode?.primaryLanguage == "zh-Hans" else { return false }
        guard let _ = target.markedTextRange else { return false }
        return true
    }
}
