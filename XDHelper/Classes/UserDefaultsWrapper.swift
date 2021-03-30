//
//  UserDefaultsWrapper.swift
//  XwgHelper
//
//  Created by Xwg on 2021/3/30.
//

import Foundation

/// UserDefaults 包装器
@propertyWrapper
public struct UserDefaultsWrapper<T> where T: Equatable {
    /// 这里的属性key 和 defaultValue 还有init方法都是实际业务中的业务代码
    /// 我们不需要过多关注
    private let key: String
    private var value: T
    
    public init(_ key: String, default value: T) {
        self.key = key
        if let local = UserDefaults.standard.object(forKey: key) as? T {
            //【key 存在 + 本地类型正确】
            self.value = local
        } else {
            //【key 存在 + 本地类型错误】或【key不存在】，需要更新本地默认值
            self.value = value
            UserDefaults.standard.setValue(value, forKey: key)
        }
    }
    
    /// wrappedValue是@propertyWrapper必须要实现的属性
    /// 当操作我们要包裹的属性时  其具体set get方法实际上走的都是wrappedValue 的set get 方法
    public var wrappedValue: T {
        get { value }
        set {
            guard value != newValue else { return }
            value = newValue
            UserDefaults.standard.set(value, forKey: key)
        }
    }
}
