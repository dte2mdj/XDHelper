import XCTest
import XDHelper

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        XCTAssert(true, "Pass")
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testXwgNamespaceExample() {
        do {
            let c = Character("🦐")
            print("\(c): \(c.xwg.isEmoji)")
        }
        do {
            let str = "1234567890"
            print("\(str): \(str.xwg.isMatching("\\d*"))")
        }
        do {
            let info: [String: Any] = [
                "name": "xwg",
                "sex": "男",
                "age": 18
            ]
            print(info.xwg.toJSONString() ?? "转换失败")
        }
    }
}
