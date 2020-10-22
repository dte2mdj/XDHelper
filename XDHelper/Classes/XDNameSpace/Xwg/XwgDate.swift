import Foundation

// MARK: - 扩展实现
public extension Xwg where Target == Date {
    
    /// 比较两个时间
    /// - Parameters:
    ///   - other: 要比较的日期
    ///   - component: 比较的精度 如 .hour 为比较到小时
    func compare(_ other: Date, toGranularity component: Calendar.Component) -> ComparisonResult {
        Calendar.current.compare(target, to: other, toGranularity: component)
    }
    
    /// 年
    var year: Int {
        dateComponents([.year]).year ?? 1970
    }
    
    /// 月
    var month: Int {
        dateComponents([.month]).month ?? 1
    }
    
    /// 日
    var day: Int {
        dateComponents([.day]).day ?? 1
    }
    
    /// 日期组件
    /// - Parameter components: Set<Calendar.Component>
    func dateComponents(_ components: Set<Calendar.Component>) -> DateComponents {
        Calendar.current.dateComponents(components, from: target)
    }
    
    /// 是否为今天
    func isInToday() -> Bool {
        Calendar.current.isDateInToday(target)
    }
    
    /// 是否是周末
    func isInWeekend() -> Bool {
        Calendar.current.isDateInWeekend(target)
    }
    
    /// 本月有多少天
    func daysInThisMonth() -> Int {
        count(of: .day, in: .month)
    }
    
    /// smaller 在 larger 中的间隔 -1 表示无效
    /// - Parameters:
    ///   - smaller: 较小
    ///   - larger: 较大
    /// - returns: 间隔数 -1 表示无效
    func count(of smaller: Calendar.Component, in larger: Calendar.Component) -> Int {
        Calendar.current.range(of: smaller, in: larger, for: target)?.count ?? -1
    }
    
    /// 本月第一天是周几 [1: "Sun", 2: "Mon", 3: "Tue", 4: "Wed", 5: "Thu", 6: "Fri", 7: "Sat"]
    /// - Parameter firstWeekday: 每周第一天是周几（默认1、周日）
    func firstWeekdayInThisMonth(_ firstWeekday: Int = 1) -> Int {
        
        var calendar = Calendar.current
        // 设置每周的第一天从周几开始,默认为1
        // [1: "Sun", 2: "Mon", 3: "Tue", 4: "Wed", 5: "Thu", 6: "Fri", 7: "Sat"]
        calendar.firstWeekday = firstWeekday
        
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: target)
        dateComponents.day = 1
        
        guard let date = calendar.date(from: dateComponents),
            let firstWeekday = calendar.ordinality(of: .weekday, in: .weekOfMonth, for: date) else { return 1 }
        
        return firstWeekday
    }
    
    func date(byAdding component: Calendar.Component, value: Int) -> Date? {
        Calendar.current.date(byAdding: component, value: value, to: target)
    }
}

// MARK: - XwgDate 扩展
extension Date: XwgWrappable {}
