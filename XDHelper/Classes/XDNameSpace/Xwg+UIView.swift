//
//  Xwg+UIView.swift
//  XwgHelper
//
//  Created by Xwg on 2021/3/30.
//

import Foundation

// MARK: UIView
extension UIView: XwgWrappable {}

// MARK: Frame 相关
public extension Xwg where Target: UIView {
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
            let superPosition = superView.xwg.frameInScreen
            let scrollViewOffset = scrollView.contentOffset
            pointInScreen = CGPoint(x: superPosition.minX + position.x - scrollViewOffset.x ,
                                    y: superPosition.minY + position.y - scrollViewOffset.y)
            
        } else {
            let superPosition = superView.xwg.frameInScreen
            let position = target.frame.origin
            pointInScreen = CGPoint(x: superPosition.minX + position.x,
                                    y: superPosition.minY + position.y)
        }
        
        return CGRect(origin: pointInScreen, size: target.frame.size)
    }
    
    var origin: CGPoint {
        get { target.frame.origin }
        set { target.frame.origin = newValue }
    }
    
    var x: CGFloat {
        get { origin.x }
        set { origin = CGPoint(x: newValue, y: y) }
    }
    
    var y: CGFloat {
        get { origin.y }
        set { origin = CGPoint(x: x, y: newValue) }
    }
    
    var size: CGSize {
        get { target.frame.size }
        set { target.frame.size = newValue }
    }
    
    var width: CGFloat {
        get { size.width }
        set { size = CGSize(width: newValue, height: height) }
    }
    
    var height: CGFloat {
        get { size.height }
        set { size = CGSize(width: width, height: newValue) }
    }
    
    var halfWidth: CGFloat {
        get { width / 2 }
        set { width = newValue * 2 }
    }
    
    var halfHeight: CGFloat {
        get { height / 2 }
        set { height = newValue * 2 }
    }
    
    var center: CGPoint {
        get { target.center }
        set { target.center = newValue }
    }
    
    var centerX: CGFloat {
        get { center.x }
        set { center = CGPoint(x: newValue, y: centerY) }
    }
    
    var centerY: CGFloat {
        get { center.y }
        set { center = CGPoint(x: centerX, y: newValue) }
    }
}

// MARK: UIResponder & UITextInput
public extension Xwg where Target: UIResponder & UITextInput {
    /// 正在拼写汉字 (textDidChange 中有效)
    var isChineseSpelling: Bool {
        guard target.textInputMode?.primaryLanguage == "zh-Hans" else { return false }
        guard let _ = target.markedTextRange else { return false }
        return true
    }
}
