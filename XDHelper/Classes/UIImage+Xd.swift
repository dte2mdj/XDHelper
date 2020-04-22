//
//  Xd+UIImage.swift
//  Pods-XDHelper_Example
//
//  Created by Xwg on 2020/3/12.
//

import Foundation
import UIKit

// MARK: UIImage
extension UIImage: XDWrappable {}

public extension Xd where Target == UIImage {
    /// base64字符串规则:  data:image/图片类型;base64,图片数据 如： data:image/png;base64,iVBORw...
    /// - Parameter string: Base64 字符串
    /// - Parameter scale: 默认1  0自动根据 UIScreen.main.scale 生成
    static func fromBase64(_ string: String, scale: CGFloat = 1) -> UIImage? {
        // 0、保存有效的base64字符串
        var base64String = string
        // 1、处理base64String数据(如果包含data头，则去掉)
        if base64String.hasPrefix("data:image") {
            guard let str = base64String.components(separatedBy: ",").last else { return nil }
            base64String = str
        }
        // 2、将处理好的base64String代码转换成Data
        guard let imgData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else { return nil }
        // 3、
        return UIImage(data: imgData, scale: scale)
    }
    
    /// 生成图片
    /// - Parameters:
    ///   - type: 图片类型 如png、jpg等
    ///   - flag: 是否需要增加标记 data:image/\(type);base64,
    func toBase64(type: String = "png", flag: Bool = true) -> String {
        /// 转换成Data
        let data: Data?
        #if swift(>=4.2)
        data = target.pngData()
        #else
        data = UIImagePNGRepresentation(target)
        #endif
        
        guard let imgData = data else { return "" }
        
        /// 生成base64字符串
        let header = flag ? "data:image/\(type);base64," : ""
        let baseString = imgData.base64EncodedString()
        /// 返回最终 base64String
        return header + baseString
    }
    
    /// 重置图片大小
    /// - Parameters:
    ///   - fillSize: 填充大小
    ///   - contentMode: 填充模式
    ///   - backgroundColor: 背景色
    @discardableResult
    func resize(_ fillSize: CGSize, contentMode: UIView.ContentMode, backgroundColor: UIColor = .clear) -> UIImage? {

        let contentMode: UIView.ContentMode = .scaleToFill
        
        let inRect = getInRect(target.size, fillSize: fillSize, contentMode: contentMode)

        UIGraphicsBeginImageContextWithOptions(fillSize, false, 0)
        
        backgroundColor.setFill()
        UIRectFill(CGRect(origin: .zero, size: fillSize))
        target.draw(in: inRect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
}

