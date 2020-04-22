//
//  XFunction.swift
//  Pods-XDHelper_Example
//
//  Created by Xwg on 2020/4/22.
//

import Foundation

/// 获取绘画位置
/// - Parameters:
///   - size: 初始大小
///   - fillSize: 最终大小
///   - contentModel: UIView.ContentMode
public func getInRect(_ size: CGSize, fillSize: CGSize, contentMode: UIView.ContentMode) -> CGRect {
    
    guard size.width > 0 && size.height > 0 else { return CGRect(origin: .zero, size: fillSize) }
    
    let width = size.width
    let height = size.height
    let fillWidth = fillSize.width
    let fillHeight = fillSize.height
    
    var inX: CGFloat = 0
    var inY: CGFloat = 0
    var inWidth = width
    var inHeight = height
    
    switch contentMode {
        
    case .scaleAspectFit,
         .scaleAspectFill:
        
        // 宽比、高比
        let ratioWidth = fillWidth / width
        let ratioHeight = fillHeight / height
        
        let ratio = contentMode == .scaleAspectFit ? min(ratioWidth, ratioHeight) : max(ratioWidth, ratioHeight)
        
        inWidth = width * ratio
        inHeight = height * ratio
        inX = (fillWidth - inWidth) / 2
        inY = (fillHeight - inHeight) / 2
        
    case .center:
        
        inX = (fillWidth - inWidth) / 2
        inY = (fillHeight - inHeight) / 2
            
    case .top:
        
        inX = (fillWidth - inWidth) / 2
            
    case .bottom:
        
        inX = (fillWidth - inWidth) / 2
        inY = fillHeight - inHeight
        
    case .left:
        
        inY = (fillHeight - inHeight) / 2
        
    case .right:
        
        inX = fillWidth - inWidth
        inY = (fillHeight - inHeight) / 2
        
    case .topLeft: break
        
    case .topRight:
        
        inX = fillWidth - inWidth
            
    case .bottomLeft:
        
        inY = fillHeight - inHeight
        
    case  .bottomRight:
        
        inX = fillWidth - inWidth
        inY = fillHeight - inHeight
        
    default:
        
        inWidth = fillWidth
        inHeight = fillHeight
    }
    
    return CGRect(x: Int(inX), y: Int(inY), width: Int(inWidth), height: Int(inHeight))
}
