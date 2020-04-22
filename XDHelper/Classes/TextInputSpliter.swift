//
//  TextInputSpliter.swift
//  Pods-XDHelper_Example
//
//  Created by Xwg on 2020/4/19.
//

import Foundation

public class TextInputSpliter: NSObject {
    /// 分隔模式
    public var splitPattern: [NSNumber] = [4]
    
    /// 最大输入长度（默认：0、不限制）
    public var maxLength: Int = 0
    
    /// 分隔符
    public var separator: Character = " "
    
    /// 检测有效性，默认不检测
    public var testValidBlock: ((_ text: String) -> Bool)?
    
    /// 有效字符串
    public private(set) var validText: String = ""
    
    /// 字符文本处理
    private func oldText(
        _ text: String,
        shouldChangeIn range: NSRange,
        replacementString string: String,
        textInputModel: UITextInputMode?,
        completionBlock: @escaping (_ final: (text: String, index: Int)) -> Void
    ) -> Bool {
        // 中文正在输入时不处理
        if textInputModel?.primaryLanguage == "zh-Hans" && ["➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒"].contains(string) { return true }
        
        // 基础文本（旧，新）
        let baseText: (old: String, new: String) = {
            // 旧
            let old = text
            
            // 新
            let isDeleteWhiteSpace = string == "" && old.enumerated().first(where: { $0.offset == range.location })?.element == separator
            let range = isDeleteWhiteSpace ? NSRange(location: range.location - 1, length: range.length) : range
            let new = (old as NSString).replacingCharacters(in: range, with: string)
            
            return (old, new)
        }()
        
        
        // 有效（文本, 光标位置）
        let valid: (text: String, index: Int) = {
            
            let text = baseText.new.replacingOccurrences(of: String(separator), with: "")
            
            let count = baseText.new
                .prefix(range.location + string.count)                  // 截取当前光标前字符串
                .replacingOccurrences(of: String(separator), with: "")  // 去空格
                .count                                                  // 有效索引位置
            
            return maxLength == 0 ? (text, count) : (String(text.prefix(maxLength)), min(count, maxLength))
        }()
        
        // 检测文本是否有效，无效直接返回
        if let test = testValidBlock, !test(valid.text) { return false }
        
        // 最终（文本, 光标位置）
        let final: (text: String, index: Int) = {
            var tmpText = valid.text    // 临时有效文本剩余
            var tmpIndex = valid.index  // 用于记录光标剩余
            var finalText = ""          // 最终 - 文本
            var finalIndex = 0          // 最终 - 光标位置
            
            let pattern = splitPattern
                .map { $0.intValue }
                .filter { $0 > 0 }
            
            guard pattern.count > 0 else { return valid }
            
            while !tmpText.isEmpty {
                
                for element in pattern {
                    
                    let startIndex = tmpText.startIndex
                    let endIndex = tmpText.count < element
                        ? tmpText.endIndex
                        : tmpText.index(tmpText.startIndex, offsetBy: element)
                    
                    let currentStr = String(tmpText[startIndex..<endIndex])
                    
                    // 更新最终文本位置
                    finalText += finalText.isEmpty ? currentStr : "\(separator)\(currentStr)"
                    
                    // 更新临时文本
                    tmpText = String(tmpText[endIndex...])
                    
                    // 更新最终光标位置
                    if tmpIndex > 0 {
                        if tmpIndex > element {
                            finalIndex += 1 + element
                        } else {
                            finalIndex += tmpIndex
                        }
                        tmpIndex -= element
                    }
                    
                    // 退出循环
                    if tmpText.isEmpty { break }
                }
            }
            
            return (finalText, finalIndex)
        }()
        
        // 需要放入动画事物中处理，否则将会出现光标异常
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            // 赋值
            self.validText = valid.text
            // 回调
            completionBlock(final)
        }
        CATransaction.commit()
        
        return false
    }
}

extension TextInputSpliter: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return oldText(textField.text ?? "", shouldChangeIn: range, replacementString: string, textInputModel: textField.textInputMode) { (text, index) in
            // 赋值
            textField.text = text
            
            // 修改为最终光标位置
            if let cursor = textField.position(from: textField.beginningOfDocument, offset: index) {
                textField.selectedTextRange = textField.textRange(from: cursor, to: cursor)
            }
        }
    }
}

extension TextInputSpliter: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return oldText(textView.text, shouldChangeIn: range, replacementString: text, textInputModel: textView.textInputMode) { (text, index) in
            // 赋值
            textView.text = text
            
            // 修改为最终光标位置
            if let cursor = textView.position(from: textView.beginningOfDocument, offset: index) {
                textView.selectedTextRange = textView.textRange(from: cursor, to: cursor)
            }
        }
    }
}
